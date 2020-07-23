function Fun=function_value(X,GY,L_G,H,W,Parameter)
part1=0.5*Parameter.lambda_1*trace(GY*L_G*GY');
part2=0.5*Parameter.lambda_4*trace(H'*H);
part3=0.5*Parameter.lambda_2*trace((W'*X-GY)'*(W'*X-GY));
part4=0.5*Parameter.lambda_3*trace(W'*W);
Fun=part1+part2+part3+part4;