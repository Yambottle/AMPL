set NODES; # nodes
set ARCS within {NODES, NODES}; # arcs

param b {NODES} default 0; # supply/demand for node i
param c {ARCS} default 0; # cost of one of flow on arc(i,j)
param l {ARCS} default 0; # lower bound of flow on arc(i,j)
param u {ARCS} default Infinity; # upper bound of flow on arc(i,j)
var x {ARCS}; # flow on arc(i,j)

minimize cost: sum{(i,j) in ARCS} c[i,j] * x[i,j];

# Flow Out(i) - Flow In(i) = b(i)
subject to flow_balance{i in NODES}:
sum{j in NODES: (i,j) in ARCS} x[i,j] - sum{j in NODES[j,i] in ARCS} x[j,i] = b[j];
subject to carry {(i,j) in ARCS}: l[i,j]<= x[i,j]<= u[i,j];