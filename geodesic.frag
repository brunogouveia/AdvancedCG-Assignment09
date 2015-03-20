//  Geodesic Fragment Shader
#version 400

//  Transformation matrices
uniform Projection {
   // Projection Matrix
   mat4 ProjectionMatrix;
   // ModelView Matrix
   mat4 ModelViewMatrix;
   // Normal matrix;
   mat4 normalMatrix;
   // ModelViewProjection Matrix
   mat4 MVP;
} projection;

uniform Light {
   // Position
   vec4 position;
   
   // Colors
   vec4 global;
   vec4 ambient;
   vec4 diffuse;
   vec4 specular;
} light;
 

//  Input from previous shader
in vec3 gPosition;
in vec3 gNormal;
in vec3 gTangent;
in vec3 gFrontColor;
in vec2 gTextCoord;

//  Texture
uniform sampler2D text;
uniform sampler2D heightMap;
uniform sampler2D normalMap;

//  Fragment color
layout (location=0) out vec4 Fragcolor;

vec4 phong()
{
   // Position in eye coordinates
   vec3 pos = gPosition;

   // Normal in eye coordinates
   vec3 N = normalize(gNormal);
   // Tangent in eye coordinates
   vec3 T = normalize(gTangent);
   // Bgtangent in eye coordinates
   vec3 B = normalize(cross(N,T));
   // Matrix that transforms from eye coordinate splace to text coordinate space
   mat3 TBN = transpose(mat3(T,B,N));
   // Compute new normal, this is a simple interpolation of the model's normal with the bump normal
   N = mix(TBN*gNormal,normalize((texture(normalMap, gTextCoord.st)).rgb*2 - 1),0.5);

   // Light vector
   vec3 L = normalize((vec3(projection.ModelViewMatrix * light.position)) - pos);
   // Tranfrom L to text coordinate space
   L = normalize(TBN * L);

   // Reflection vector
   vec3 R = reflect(-L, N);

   // View vector in eye coordinates
   vec3 V = normalize(-pos);
   // V in text coordinate space
   V = normalize(TBN*V);

   // Diffuse light intensity
   float Id = max(0.0, dot(N, L));

   // Specular light intensity
   float Is = (Id > 0.0) ? pow(max(0.0, dot(R, V)), 1) : 0.0;

   return light.global + light.ambient + Id*light.diffuse + Is*light.specular;
}

void main()
{
   // Set color
   Fragcolor = texture(text,gTextCoord.st)*phong();
}
