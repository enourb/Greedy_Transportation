% This code generates an array that contains all
% 6 node graphs with 5 edges

W = {};
for a1 = 0:1
    for a2 = 0:1
        for a3 = 0:1
            for a4 = 0:1
                for a5 = 0:1
                    for a6 = 0:1
                        for a7 = 0:1
                            for a8 = 0:1
                                for a9 = 0:1
                                    for a10 = 0:1
                                        for a11 = 0:1
                                            for a12 = 0:1
                                                for a13 = 0:1
                                                    for a14 = 0:1
                                                        for a15 = 0:1
                                                            G = [0 a1 a2 a3 a4 a5;
                                                                 0 0 a6 a7 a8 a9;
                                                                 0 0 0 a10 a11 a12;
                                                                 0 0 0 0 a13 a14;
                                                                 0 0 0 0 0 a15;
                                                                 0 0 0 0 0 0];
                                                             if sum(sum(G)) == 5
                                                                 F = G + transpose(G);
                                                                 W{end+1} = F;
                                                             end
                                                        end
                                                    end
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end

save('allgraphs.mat', 'W')

                                                    
                                                    
                                                                 