% READ ME
%
% To run this file, the user needs to import a few files from my github
% repository available in the PCA folder:
%
%       1)      meancent.m  -  a MATLAB function that returns the
%       mean-centered data matrix B of a non-mean-centered data matrix A:
%           Usage: [~, B] = meancent(A);
%
%       2)      The following csv data matrices:
%                   a) diabetes_matlab.csv
%                   b) diabetes_YN.csv
%                   a) drinking.csv
%                   a) drinking_indicator.csv
% 
% If the user does not want to do that, comment out lines 150 and beyond.
% Then, you will be able to see the ovarian cancer data within MATLAB.


load ovariancancer; % Load ovarian cancer data

% obs = genetic data from 216 patients.
% grp = signifier of ovarian cancer. 1 means a patient has cancer.

[U,S,V] = svd(obs,'econ'); 

figure(1);
hold off;
subplot(1,3,1);
for i=1:size(obs,1)
    x = V(:,1)'*obs(i,:)';  % Inner Product of Eigen Genome 1 with each
    y = V(:,2)'*obs(i,:)';
    z = V(:,3)'*obs(i,:)';
    if(grp{i}=='Cancer')
        plot3(x,y,z,'rx','LineWidth',2); hold on;
    else
        plot3(x,y,z,'bo','LineWidth',2); hold on;
    end
    grid on;
end
xlabel("PC1"); ylabel("PC2"); zlabel("PC3");
title("Cancer Data: Mean Centered Data Projected in 3D Space (top 3 PC's)");

hold off;
subplot(1,3,2);
semilogy(1:size(S,2), diag(S));
title("Magnitude of Singular Values");
xlabel("Index");
ylabel('$\log(\sigma_i)$', 'Interpreter', 'latex');

denom = [];
denom(1) = S(1,1);
for i = 2:size(S,2)
    denom(i) = denom(i-1) + S(i,i);
end

subplot(1,3,3);
plot(1:size(S,2), 100*denom/denom(end));
axis([0 size(S,2)+1 0 105]);
title("Percentage of Variance Captured (R) for PCA of Dimension k");
xlabel("k");
ylabel("R (%)");

% This is the split dataset where PCAs of the cancer patients and
% non-cancer patients are done independently:

Cobs = obs(1:121, :);
Nobs = obs(122:end,:);

[U,S,V] = svd(Cobs,'econ'); 

figure(2);
hold off;
subplot(2,3,1);
for i=1:size(Cobs,1)
    x = V(:,1)'*Cobs(i,:)';  % Inner Product of Eigen Genome 1 with each
    y = V(:,2)'*Cobs(i,:)';
    z = V(:,3)'*Cobs(i,:)';
    if(grp{i}=='Cancer')
        plot3(x,y,z,'rx','LineWidth',2); hold on;
    else
        plot3(x,y,z,'bo','LineWidth',2); hold on;
    end
    grid on;
end
xlabel("PC1"); ylabel("PC2"); zlabel("PC3");
title("Mean Centered Data Projected in 3D Space (top 3 PC's) - Cancer");

hold off;
subplot(2,3,2);
semilogy(1:size(S,2), diag(S));
title("Magnitude of Singular Values - Cancer");
xlabel("Index");
ylabel('$\log(\sigma_i)$', 'Interpreter', 'latex');

denom = [];
denom(1) = S(1,1);
for i = 2:size(S,2)
    denom(i) = denom(i-1) + S(i,i);
end

subplot(2,3,3);
plot(1:size(S,2), 100*denom/denom(end));
axis([0 size(S,2)+1 0 105]);
title("Percentage of Variance Captured (R) for PCA of Dimension k - Cancer");
xlabel("k");
ylabel("R (%)");

[U,S,V] = svd(Nobs,'econ'); 

subplot(2,3,4);
for i=1:size(Nobs,1)
    x = V(:,1)'*Nobs(i,:)';  % Inner Product of Eigen Genome 1 with each
    y = V(:,2)'*Nobs(i,:)';
    z = V(:,3)'*Nobs(i,:)';
    if(grp{i+121}=='Cancer')
        plot3(x,y,z,'rx','LineWidth',2); hold on;
    else
        plot3(x,y,z,'bo','LineWidth',2); hold on;
    end
    grid on;
end
xlabel("PC1"); ylabel("PC2"); zlabel("PC3");
title("Mean Centered Data Projected in 3D Space (top 3 PC's) - Normal");

hold off;
subplot(2,3,5);
semilogy(1:size(S,2), diag(S));
title("Magnitude of Singular Values - Normal");
xlabel("Index");
ylabel('$\log(\sigma_i)$', 'Interpreter', 'latex');

denom = [];
denom(1) = S(1,1);
for i = 2:size(S,2)
    denom(i) = denom(i-1) + S(i,i);
end

subplot(2,3,6);
plot(1:size(S,2), 100*denom/denom(end));
axis([0 size(S,2)+1 0 105]);
title("Percentage of Variance Captured (R) for PCA of Dimension k - Normal");
xlabel("k");
ylabel("R (%)");




% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% 
% Student Drinking Data
%
% Download the dataset here: https://www.kaggle.com/datasets/uciml/student-alcohol-consumption

figure(3);

A = readmatrix('drinking.csv');
grp = readmatrix('drinking_indicator.csv');

% Mean Center
[~, B] = meancent(A);

[U,S,V] = svd(B, 'econ');

subplot(1,3,1);
hold off;
for i=1:size(B,1)
    x = V(:,1)'*B(i,:)';
    y = V(:,2)'*B(i,:)';
    z = V(:,3)'*B(i,:)';
    if(grp(i)>3)
        plot3(x,y,z,'rx','LineWidth',2); hold on;
    else
        plot3(x,y,z,'bo','LineWidth',2); hold on;
    end
end
grid on;
title("Student Data Projected to 3D PCA Space");
xlabel("PC1"); ylabel("PC2"); zlabel("PC3");

subplot(1,3,2);
semilogy(1:size(S,2)-1, diag(S(1:end-1,1:end-1)));
title("Magnitude of Singular Values");
xlabel("Index");
ylabel('$\log(\sigma_i)$', 'Interpreter', 'latex');

denom = [];
denom(1) = S(1,1);
for i = 2:size(S,2)
    denom(i) = denom(i-1) + S(i,i);
end

subplot(1,3,3);
plot(1:size(S,2), 100*denom/denom(end));
axis([0 size(S,2)+1 0 105]);
title("Percentage of Variance Captured (R) for PCA of Dimension k");
xlabel("k");
ylabel("R (%)");

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% 
% Diabetes Data
%
% Download the dataset here: https://www.kaggle.com/datasets/akshaydattatraykhare/diabetes-dataset


A = readmatrix('diabetes_matlab.csv');
grp = readmatrix('diabetes_YN.csv');

% Mean Center
[~, B] = meancent(A);

[U,S,V] = svd(B, 'econ');

figure(4);
subplot(1,3,1);
hold off;
for i=1:size(B,1)
    x = V(:,1)'*B(i,:)';
    y = V(:,2)'*B(i,:)';
    z = V(:,3)'*B(i,:)';
    if(grp(i)==1)
        plot3(x,y,z,'rx','LineWidth',2); hold on;
    else
        plot3(x,y,z,'bo','LineWidth',2); hold on;
    end
    grid on;
end
title("Diabetes Data Projected to 3D PCA Space");
xlabel("PC1"); ylabel("PC2"); zlabel("PC3");

subplot(1,3,2);
semilogy(1:size(S,2)-1, diag(S(1:end-1,1:end-1)));
title("Magnitude of Singular Values");
xlabel("Index");
ylabel('$\log(\sigma_i)$', 'Interpreter', 'latex');

subplot(1,3,3);

denom = [];
denom(1) = S(1,1);
for i = 2:size(S,2)
    denom(i) = denom(i-1) + S(i,i);
end

plot(1:size(S,2), 100*denom/denom(end));
axis([0 size(S,2)+1 0 105]);
title("Percentage of Variance Captured (R) for PCA of Dimension k");
xlabel("k");
ylabel("R (%)");



