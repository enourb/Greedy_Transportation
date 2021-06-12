% Greedy Algorithm Code
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

% transportation adjacency matrix
G = zeros(length(P));
% transportation adjacenecy matrix weighted by length
J = zeros(length(P));

% Construct Transportation network
time = 6;
for t = 1:time
    % construct a net benefit matrix at time t
    N = zeros(length(P));
    for u = 1:length(P)
        for v = u:length(P)
            if G(u, v) == 0
                N(u, v) = build(u, v, P, B, J, L);
                N(v, u) = N(u, v);
            end
        end
    end
    % select the edge with highest net benefit
    [maxVal, idx] = max(N(:));
    [a, b] = ind2sub(size(N), idx);
    % update the adjacency matrices only if max net benefit is positive
    if N(a,b) > 0
        G(a,b) = 1;
        G(b,a) = 1;
        J = weightadj(G, L);
    end
end
% net benefit of remaining edges
N;
% adjacency matrix at time t
G
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

% Net benefit of building line i, j
function build_profit = build(u, v, P, B, J, L)
build_cost = B(u, v);
path_length_u = distances(graph(J),u,[1:length(J)]);
path_length_v = distances(graph(J),v,[1:length(J)]);
commuter_profit = 0;
% commuter profit if u, v unconnected 
if distances(graph(J),v,u) == Inf
    for j = 1:length(path_length_u)
        for i = 1:length(path_length_v)
            % only consider when both j connected to u and i connected to v
            if path_length_u(1,j) ~= Inf && path_length_v(1,i) ~= Inf
                profit = 2*(P(j, i) - time_cost(path_length_u(1,j) + L(u, v) - path_length_v(1,i)));
                % add to total commuter profit when positive
                if profit >0
                    commuter_profit = commuter_profit + profit;
                end
            end
        end
    end
% commuter profit if u,v connected
else
    for j = 1:length(path_length_u)
        for i = 1:length(path_length_v)
            % only consider when both j connected to u and i connected to v
            if path_length_u(1,j) ~= Inf && path_length_v(1,i) ~= Inf
                profit = time_cost(distances(graph(J),j,i)) - time_cost(path_length_u(1,j) + L(u, v) + path_length_v(1,i));
                % add to total commuter profit when positive
                if profit >0
                    commuter_profit = commuter_profit + profit;
                end
            end
        end
    end
end

build_profit = commuter_profit - build_cost;
end

function time = time_cost(length)
% speed coefficient
s = .5;
% time exponent
p = .5;
% time as concave function of length
time = (s*length)^p;
end