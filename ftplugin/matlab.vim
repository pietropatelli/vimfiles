map <buffer> <F3> :AsyncRun matlab '-nodesktop', '-nosplash', '-r', "try run('%'); while ~isempty(get(0,'Children')); pause(0.5); end; catch ME; disp(ME.message); exit(1); end; exit(0);"]  <CR>

