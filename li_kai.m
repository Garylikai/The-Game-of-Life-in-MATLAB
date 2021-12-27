%  The following code is written by Kai Li.
%  This MATLAB assignment requires implementing the Game of Life 
%  for a 7 × 7 universe with periodic boundary conditions. 
%  The seed configuration is chosen to be the glider, with a period of 4.
%  The simulation lasts for 56 generations with each 
%  generation pause-time equals to 0.1 seconds.

square_size = 7;
nr_generation = 56;
pause_time = 0.1;
advance(square_size, nr_generation, pause_time)

function advance(square_size, nr_generation, pause_time)
    %  Write a function advance that takes in two copies of a universe of
    %  arbitrary size, and passes them back out so that one configuration  
    %  is the child (the next generation) of the other configuration.

    %  First, we initialize the positions for glider seed configuration.
    %  We name the first glider "glider1" with sparse matrix A
    %  representing its positions in the universe.
    A = sparse(square_size, square_size);
    A(4, square_size - 1) = 1;
    A(5, square_size - 2) = 1;
    A(3, square_size - 3) = 1;
    A(4, square_size - 3) = 1;
    A(5, square_size - 3) = 1;
    
    %  As required in this assignment, we build another glider seed
    %  configuration, named "glider2" by initializing its positions 
    %  so that "glider2" is the child of "glider1".
    %  "glider 2" corresponds with sparse matrix B.
    B = sparse(square_size, square_size);
    B(3, square_size - 2) = 1;
    B(5, square_size - 2) = 1;
    B(4, square_size - 3) = 1;
    B(5, square_size - 3) = 1;
    B(4, square_size - 4) = 1;

    %  Next, we plot the initial seed configurations for both gliders.
    %  The figure is plotted with points which are called 
    %  "dual cell" in the corresponding cells.
    [i,j] = find(A);
    [k,l] = find(B);
    figure(gcf);
    glider1 = plot(i, j, 'sk', 'markersize', 10);
    hold on
    glider2 = plot(k, l, 'bo', 'markersize', 12);
    set(gca,'XTickLabel', [], 'YTickLabel',[]);
    axis([0, square_size + 1, 0, square_size + 1])
    shg
    drawnow
    pause(pause_time)
    
    %  In this assignment, Moore neighborhood of cells are considered.
    %  Thus, there are eight possible neighbors for each cell,
    %  either alive or dead. 
    %  The revolution of a cell depends on the cell's
    %  current state and its eight neighbors.
    %  Four cardinal directional vectors of the eight neighbors are created.
    %  We use periodic boundary conditions at the edges.
    n = [square_size, 1:square_size - 1]; %  North
    e = [2:square_size, 1]; %  East
    s = [2:square_size, 1]; %  South
    w = [square_size, 1:square_size - 1]; %  West

    for generation = 1:nr_generation
        %  Here, we need to count the number of cells in the
        %  Moore neighborhood that are alive.
        %  Moore neighborhood contains cells from the four cardinal
        %  directions and the four intercardinal directions.
        M = A(n,:) + A(:,e) + A(s,:) + A(:,w) + A(n,e) + ...
            A(s,e) + A(n,w) + A(s,w);
        N = B(n,:) + B(:,e) + B(s,:) + B(:,w) + B(n,e) + ... 
            B(s,e) + B(n,w) + B(s,w);
    
        %  A cell that is alive, with exactly 2 or 3 neighbors
        %  that are also alive in the current generation, 
        %  is alive in the next generation. (survival)
        %  A cell that is dead, with exactly 3 neighbors that 
        %  are alive in the current generation, is alive in  
        %  the next generation. (birth by reproduction)
        A = ((M == 2) & A) | (M == 3);
        B = ((N == 2) & B) | (N == 3);
    
        %  Retrieve new positions after each generation and plot.
        [i,j] = find(A);
        [k,l] = find(B);
        set(glider1, 'XData', i, 'YData', j)
        set(glider2, 'XData', k, 'YData', l)
        shg
        drawnow
        pause(pause_time)
    end
    
end