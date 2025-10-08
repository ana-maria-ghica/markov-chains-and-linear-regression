function [path] = heuristic_greedy(start_position, probabilities, Adj)
	n = length(probabilities) - 2;
	% visited = zeros(n, 1);
	visited = sparse(n, 1);

	% initial, path contine doar pozitia de start
	path = [start_position];
	disp(path);
	% marchez pozitia ca fiind vizitata
    visited(start_position) = 1;
    
    while ~isempty(path)
        position = path(end);
        
		% daca am ajuns la win,  o adaug in path si dau return
        if Adj(position, n+1) == 1
			path = [path, n+1];
			disp(path);
            return;
        end

		% verific ce vecini sunt nevizitati
		unvisited_neigh = 0;
		for i = 1:n
			if Adj(position, i) == 1 && visited(i) == 0
				unvisited_neigh = 1;
				break;
			end
		end
		
		% daca nu am vecini nevizitati "dau inapoi"
		if unvisited_neigh == 0
			path(end) = [];
		else
			% caut sa determin cea mai mare probabilitate existenta
			% dintre toti vecinii nevizitati
			max_prob = -1;
			neigh = 0;
			for i = 1:n
				if Adj(position, i) == 1 && visited(i) == 0
					if probabilities(i) > max_prob
						max_prob = probabilities(i);
						neigh = i;
					end
				end
			end
			% marchez vecinul vizitat si imi continui drumul
			visited(neigh) = 1;
			path = [path, neigh];
		end
    end
	%disp(Adj);
	disp(visited);
	disp(path);
end