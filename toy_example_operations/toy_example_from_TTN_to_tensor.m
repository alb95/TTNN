function T = toy_example_from_TTN_to_tensor(B)
T = B{1,1};
T = tensorprod(T, B{2,1}, 1,3); 
T = tensorprod(T, B{2,2}, 1,2); 
T = tensorprod(T, B{2,3}, 1,3); 
T = tensorprod(T, B{3,1}, 1,3);
T = tensorprod(T, B{3,2}, 1,2);
T = permute(T, [2,3,4,5,6,1]);
T = tensorprod(T, B{3,3}, 1,2);
T = tensorprod(T, B{3,4}, 1,2);
T = tensorprod(T, B{4,1}, 1,2);
T = tensorprod(T, B{4,2}, 1,2);
T = permute(T, [5,6,1,2,3,4]);

