adult(angel).
adult(mimi).

child(baby).

immature(X):- adult(X), fail.
immature(X).
