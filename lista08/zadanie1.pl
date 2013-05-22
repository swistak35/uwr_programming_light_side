tree(leaf) --> "*",!.
tree(node(A,B)) --> "(", tree(A), tree(B), ")".