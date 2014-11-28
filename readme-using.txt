To start DSS prototype:

1) Type ‘testingtool’ in matlab command line.

2) Then press Start in experiment section
3) Then choose interactive method from a list (see below)
4) Then choose testing problem from a list and press START (section Solving)

5) Choose initial solution (recommended to use from second point in the list) (Pareto optimal)
6) Choose goal solution (Pareto optimal)

7) Provide preference information in section Preference information parameters` values (please fill all fields).
8) Choose diagrams you want to use and press button Get first solution.

9) Then update preference information until final solution was found and press STOP, fill termination reason.
10) If you want to use the functionality of the goal solution obtaining by single iteration press button 'Single iteration':
	1) provide evolutionary algorithm and their parameters
	2) in the goal solution section press On if you want provide your own the goal solution values in criteria value space or choose 'off' if you want to use defined goal solution in main window.
	2) press button 'start' and after all generations of EA the preference information will be obtained then press 'Set for iteration' and preference value will be copped to the main window.

11) If you want to use problem metrics` values open pgAdmin tool, then open database 'afrodita', then find 
 view 'stat_data_last1_6' and find your problem data (subexperiments) by using number (in sub_exp_id field) and which is located in section 'Testing problem' in bottom as numbers.

==========================================================DEV==========================
For development purposes use matlab guide tool for modify windows and functionality of DSS prototype.
Open guide in DSS root path find file ''testingtool.fig' (main window) or 'ea_params.fig' (single iteration window) or 'stoping.fig' (termination reason window)

