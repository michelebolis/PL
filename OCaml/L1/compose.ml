let compose f g x = f (g x);;
let compose' (f, g) x = f (g x);;