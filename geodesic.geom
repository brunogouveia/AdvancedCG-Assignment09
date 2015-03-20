//  Geodesic Geometry Shader

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

//  Triangles in and out
layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;

//  Coordinates and weights in and out
in  vec3 tePosition[3];
in  vec3 teNormal[3];
in  vec3 teTangent[3];
in  vec3 teFrontColor[3];
in  vec2 teTextCoord[3];

in  vec3 tePatchDistance[3];
out vec3 gPosition;
out vec3 gNormal;
out vec3 gTangent;
out vec3 gFrontColor;
out vec2 gTextCoord;
out vec3 gPatchDistance;
out vec3 gTriDistance;

void main()
{
   //  These attributes are the same for all vertices
   gNormal = normalize(teNormal[0]);
   gTangent = normalize(teTangent[0]);
   gFrontColor = teFrontColor[0];

   //  First vertex
   gPosition = tePosition[0];
   gTextCoord = teTextCoord[0];
   gl_Position = gl_in[0].gl_Position;
   EmitVertex();

   //  Second vertex
   gPosition = tePosition[1];
   gTextCoord = teTextCoord[1];
   gl_Position = gl_in[1].gl_Position;
   EmitVertex();

   //  Third vertex
   gPosition = tePosition[2];
   gTextCoord = teTextCoord[2];
   gl_Position = gl_in[2].gl_Position;
   EmitVertex();

   //  Done with triangle
   EndPrimitive();
}
