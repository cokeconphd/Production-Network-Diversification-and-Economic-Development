% Import 'master1' Excel file
fulldata = xlsread('master1.xlsx', 'OECD.Stat export', 'G5:AM39410');

% Set parameters
M = 61;  % number of countries
N = 33;  % number of industries
K = 16;  % number of years

colIndex = 41;  % Desired column index
selectedYear = 1995;  % Replace with the desired year

% Initialize variables
supermat = zeros(N, N, M);

% Organize Data into Matrices
for country = 1:M
    start = (selectedYear - 1995) * N * (K + 1) + (country - 1) * N + 6;
    finish = start + N - 1;
    % Extract the specified column from the matrix of the selected year
    supermat(:, :, country) = fulldata(start:finish, colIndex);
end

% Save Matrices to Files
matrixname = strjoin({'mat', num2str(selectedYear)}, '');
out = strjoin({'cons', num2str(selectedYear), '.mat'}, '');
save(out, matrixname, 'supermat');
