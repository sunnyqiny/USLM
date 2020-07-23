function GY_tp1=update_GY(W_tp1,X_t,G_t,L_Gt,Parameter)
P1=Parameter.lambda_2*W_tp1'*X_t;
[mL,nL]=size(L_Gt);
P2=(Parameter.lambda_1*L_Gt+Parameter.lambda_2*eye(mL))*X_t'*W_tp1;
GY_tp1_hat=G_t.*sqrt(P1./P2');

GY_tp1=GY_tp1_hat;
