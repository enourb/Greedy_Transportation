% Omniscient Algorithm Code
% Clear Workspace before running

% profit matrix
P = [0 4 8 3 3 4;
     0 0 4 5 4 6;
     0 0 0 6 2 4;
     0 0 0 0 6 5;
     0 0 0 0 0 1;
     0 0 0 0 0 0];
P = P + transpose(P);
 
% length matrix
L = [0 5 6 10 5 10;
     0 0 6 4 4 10;
     0 0 0 7 3 10;
     0 0 0 0 4 10;
     0 0 0 0 0 2;
     0 0 0 0 0 0];
L = L + transpose(L);

% build cost
b = 1.5;
% build cost matrix
B = b*L;

% load all possible graphs of with 6 vertices and 5 edges
load('allgraphs');

max_graph = zeros(length(P));
max = 0;

% create a matrix with results from model
Q = [0 0 1 0 0 0;
     0 0 1 1 0 0;
     1 1 0 0 1 0;
     0 1 0 0 0 0;
     0 0 1 0 0 1;
     0 0 0 0 1 0];
 QJ = weightadj( Q, L);
            
time = 6;
for w = 1:length(W)
    G = W{w};
    
    J = zeros(length(P));
    J = weightadj(G, L);
    
    total_profit = total(P, B, J, G);
    
    if total_profit > max
        max = total_profit;
        max_graph = G;
    end
end
max_graph;
% optimal value
max
% greedy value
greedy = total(P, B, QJ, Q)
% greedy compared to total
greedy/max


% Weighted Adjacency Matrix by Length
function D = weightadj(G, L)
D = zeros(length(G));
for i = 1:length(G)
    for j = 1:length(G)
        if(G(i, j) == 1)
            D(i, j) = L(i, j);
        else
            D(i, j) = 0;
        end
    end
end
end

function total_profit = total(P, B, J, G)
commuter_profit = 0;
build_cost = 0;
for u = 1:length(P)
    for v = u:length(P)
    path_length = distances(graph(J),u,v);
        if path_length ~= Inf
            profit = 2*(P(u, v) - time_cost(path_length));
            if profit > 0
                commuter_profit = commuter_profit + profit;
            end
        end
        if G(u, v) == 1
            build_cost = build_cost + B(u, v);
        end
    
    end
end
total_profit = commuter_profit - build_cost;
end

function time = time_cost(length)
% speed coefficient
s = .5;
% time exponent
n = .5;
% time as concave function of length
time = (s*length)^n;
end