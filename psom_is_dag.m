function [flag_dag,list_vert_cycle] = psom_is_dag(adj)
% Test if a sparse binary matrix is the adjacency matrix of a directed
% acyclic graph
%
% SYNTAX :
% [FLAG_DAG,LIST_VERT_CYCLE] = PSOM_IS_DAG(ADJ)
%
% ADJ         
%  (sparse binary matris) ADJ(I,J) == 1 only if there is an edge from
%  J to I.
% FLAG_DAG
%  (boolean) FLAG_DAG == 1 only if ADJ is the adjacency matrix of an
%  acyclic directed graph.
% LIST_VERT_CYCLE
%  (vector) the list of vertices number which are involved in cycles.
%
% Copyright (c) Pierre Bellec, Montreal Neurological Institute, 2008-2010.
% CRIUGM, DIRO, University of Montreal, 2010-2017.
% Maintainer : pierre.bellec@criugm.qc.ca
% See licensing information in the code.
% Keywords : string

% Permission is hereby granted, free of charge, to any person obtaining a copy
% of this software and associated documentation files (the "Software"), to deal
% in the Software without restriction, including without limitation the rights
% to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
% copies of the Software, and to permit persons to whom the Software is
% furnished to do so, subject to the following conditions:
%
% The above copyright notice and this permission notice shall be included in
% all copies or substantial portions of the Software.
%
% THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
% IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
% FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
% AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
% LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
% OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
% THE SOFTWARE.

%% SYNTAX
if ~exist('adj','var')
    error('SYNTAX: [FLAG_DAG,LIST_VERT_CYCLE] = PSOM_IS_DAG(ADJ). Type ''help psom_is_dag'' for more info.')
end

flag_dag = true;
nb_vertices = size(adj,1);
list_vert_cycle = [];
lab_vertices = 1:nb_vertices;

while ~isempty(adj) && flag_dag
    
    [x,y] = find(adj);
    mask_not_term = ismember(1:size(adj,1),y);
    
    if  ~any(~mask_not_term) 
        %% There is no terminal node, but the matrix is not empty,
        %% there must be a cycle
        flag_dag = false;
        list_vert_cycle = lab_vertices;
    else
        %% Get rid of terminal nodes and start again
        adj = adj(mask_not_term>0,mask_not_term>0);
        lab_vertices = lab_vertices(mask_not_term>0);
    end
    
end