function s = makeDAEfile(vertices, triangles, normals, colors)

% find the number of vertices and triangles
%
% Copyright (C) 2024, Danuser Lab - UTSouthwestern 
%
% This file is part of Morphology3DPackage.
% 
% Morphology3DPackage is free software: you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation, either version 3 of the License, or
% (at your option) any later version.
% 
% Morphology3DPackage is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
% 
% You should have received a copy of the GNU General Public License
% along with Morphology3DPackage.  If not, see <http://www.gnu.org/licenses/>.
% 
% 
vertexCount = numel(vertices)/3;
triangleCount = numel(triangles)/3;

% transpose matrices
vertices = vertices';
triangles = triangles';
normals = normals';
colors = colors';

% enlarge the triangles matrix for some reason
triangles = [triangles(1,:); triangles(1,:); triangles(1,:); triangles(2,:); triangles(2,:); triangles(2,:); triangles(3,:); triangles(3,:); triangles(3,:)];

% set the triangles to 0-start indexing
triangles = triangles-1;

% set the contents of the file
n = '\n';
s = ['<COLLADA xmlns="http://www.collada.org/2005/11/COLLADASchema" version="1.4.1">' n...
'  <library_geometries>' n...
'    <geometry id="geometry_0" name="triangles_0">' n...
'      <mesh>' n...
'        <source id="vertex_0">' n...
'          <float_array count="' num2str(3*vertexCount) '" id="vertex_0-array">' sprintf('%7f ',vertices(:)) '</float_array>' n...
'          <technique_common>' n...
'            <accessor count="' num2str(vertexCount) '" source="#vertex_0-array" stride="3">' n...
'              <param name="X" type="float" />' n...
'              <param name="Y" type="float" />' n...
'              <param name="Z" type="float" />' n...
'            </accessor>' n...
'          </technique_common>' n...
'        </source>' n...
'        <source id="normal_0">' n...
'          <float_array count="' num2str(3*vertexCount) '" id="normal_0-array">' sprintf('%5f ',normals(:)) '</float_array>' n...
'          <technique_common>' n...
'            <accessor count="' num2str(vertexCount) '" source="#normal_0-array" stride="3">' n...
'              <param name="X" type="float" />' n...
'              <param name="Y" type="float" />' n...
'              <param name="Z" type="float" />' n...
'            </accessor>' n...
'          </technique_common>' n...
'        </source>' n...
'        <source id="rgba_0">' n...
'          <float_array count="' num2str(4*vertexCount) '" id="rgba_0-array">' sprintf('%4f ',colors(:)) '</float_array>' n...
'          <technique_common>' n...
'            <accessor count="' num2str(vertexCount) '" source="#rgba_0-array" stride="4">' n...
'              <param name="R" type="float" />' n...
'              <param name="G" type="float" />' n...
'              <param name="B" type="float" />' n...
'              <param name="A" type="float" />' n...
'            </accessor>' n...
'          </technique_common>' n...
'        </source>' n...
'        <vertices id="vertex_0-vertices">' n...
'          <input semantic="POSITION" source="#vertex_0" />' n...
'        </vertices>' n...
'        <triangles count="' num2str(triangleCount) '" material="matsym_0">' n...
'          <input offset="1" semantic="NORMAL" source="#normal_0" />' n...
'          <input offset="2" semantic="COLOR" source="#rgba_0" />' n...
'          <input offset="0" semantic="VERTEX" source="#vertex_0-vertices" />' n...
'          <p>' sprintf('%i ',triangles(:)) '</p>' n...
'        </triangles>' n...
'      </mesh>' n...
'    </geometry>' n...
'  </library_geometries>' n...
'  <library_visual_scenes>' n...
'    <visual_scene id="_initial_view_">' n...
'      <node id="node_1" name="node_1">' n...
'          <instance_geometry url="#geometry_0">' n...
'          </instance_geometry>' n...
'      </node>' n...
'    </visual_scene>' n...
'  </library_visual_scenes>' n...
'  <scene>' n...
'    <instance_visual_scene url="#_initial_view_" />' n...
'  </scene>' n...
'</COLLADA> ' n];
