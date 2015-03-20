//  Geodesic Vertex Shader

#version 400

//  Coordinates in and out
layout(location = 0) in vec4 Vertex;
layout(location = 1) in vec3 Normal;
layout(location = 2) in vec3 Tangent;
layout(location = 3) in vec3 Color;
layout(location = 4) in vec2 TextCoord;

//  Output to next shader
out vec3 IPosition;
out vec3 INormal;
out vec3 ITangent;
out vec3 FrontColor;
out vec2 ITextCoord;

void main()
{
   //  Coordinate passthrough
   IPosition = Vertex.xyz;
   ITangent = Tangent;
   INormal = Normal;
   FrontColor = Color;
   ITextCoord = TextCoord;
}
