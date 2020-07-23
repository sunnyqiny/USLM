clear;clc;
Data=read_file('CBF_TRAIN');
[mD,nD]=size(Data);
Y_true=Data(:,1);
DT=Data(:,2:end);
DT=z_regularization(DT);% regularize time series data;
T=[(nD-1)*ones(mD,1),DT]; % Each element in first column of time series matrix is the length of the time series in that row;
N=mD; % Number of time series

Parameter.C=2;% the number of clusters
Parameter.Imax=20; % the number of internal iterations
Parameter.eta=0.01; % learning rate
Parameter.epsilon=0.1; % internal convergence parameter

%% Parameters ilitialization
% % % Parameter.Lmin=[0.05 0.1 0.15 0.2 0.25]; % the minimum length of shapelets we plan to learn
% % % Parameter.k=[1 2 3 4 5];% the number of shapelets in equal length 
% % % Parameter.R=[1 2];% the number of scales of shapelets length 
% % % Parameter.C=2;% the number of clusters
% % % Parameter.alpha=[-20 -100]; % parameter in Soft Minimum Function
% % % Parameter.sigma=10.^[-8 -4 -2 0 2 4 8]; % parameter in RBF kernel
% % % Parameter.lambda_1=10.^[-8 -4 -2 0 2 4 8]; % regularization parameter
% % % Parameter.lambda_2=10.^[-8 -4 -2 0 2 4 8];% regularization parameter
% % % Parameter.lambda_3=10.^[-8 -4 -2 0 2 4 8]; % regularization parameter
% % % Parameter.lambda_4=10.^[-8 -4 -2 0 2 4 8]; % regularization parameter
% % % Parameter.Imax=20; % the number of internal iterations
% % % Parameter.eta=0.01; % learning rate
% % % Parameter.epsilon=0.1; % internal convergence parameter

Result=[];
GY_0=[];
GS_0=[];
GW_0=[];
%Unsupervised Shapelets Learning Algorithm
for Parameter_Lmin=[0.05 0.1 0.15 0.2 0.25]*(nD-1); % the minimum length of shapelets we plan to learn
    Parameter.Lmin=floor(Parameter_Lmin);
    for Parameter_k=[1 2 3 4 5];% the number of shapelets in equal length 
        Parameter.k=Parameter_k;
        for Parameter_R=[1 2];% the number of scales of shapelets length 
            Parameter.R=Parameter_R;
            for Parameter_alpha=[-20 -100]; % parameter in Soft Minimum Function
                Parameter.alpha=Parameter_alpha;
                for Parameter_sigma=10.^[-8 -4 -2 0 2 4 8]; % parameter in RBF kernel
                    Parameter.sigma=Parameter_sigma;
                    for Parameter_lambda_1=10.^[-8 -4 -2 0 2 4 8]; % regularization parameter
                        Parameter.lambda_1=Parameter_lambda_1;
                        for Parameter_lambda_2=10.^[-8 -4 -2 0 2 4 8];% regularization parameter
                            Parameter.lambda_2=Parameter_lambda_2;
                            for Parameter_lambda_3=10.^[-8 -4 -2 0 2 4 8]; % regularization parameter
                                Parameter.lambda_3=Parameter_lambda_3;
                                for Parameter_lambda_4=10.^[-8 -4 -2 0 2 4 8]; % regularization parameter
                                    Parameter.lambda_4=Parameter_lambda_4;
                                    tic;
                                    [W_star, Y_star, S_star,GY_star,S_0,Y_0,W_0,F_tp1,wh_time]=GUSLA(T,Parameter);
                                    %Y_star is the ultimate pseudo-class label matrix under the specific parameters;
                                    %S_star is the shapelets learned by USLA under the specific parameters;
                                    %W_star is the pseudo-classifier under the specific parameters.
                                    time=toc; % time record
                                    %Y_true_matrix=reshape_y_ture(Y_true,Parameter.C);
                                    RI = RandIndex(Y_star,Y_true') % Calculate Rand Index
                                    Result=[Result;RI time Parameter.Lmin Parameter.k Parameter.R Parameter.alpha Parameter.sigma Parameter.lambda_1 Parameter.lambda_2 Parameter.lambda_3 Parameter.lambda_4];
                                    GY_0=[GY_0;Y_0];
                                    GS_0=[GS_0;S_0];
                                    GW_0=[GW_0;W_0];
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end


% W_star
% GY_star
% Y_star
% S_star
% norm(S_star(1,:)-S_star(2,:))+norm(S_star(3,:)-S_star(4,:))

