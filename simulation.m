%{ 
Name: Ishmal Khalid, Net ID: ik1299
Date: December 5th, 2019. 
Program:Assignment.m
Description: This program models the temperature distribution in a thin
metal plate.
%}

%initialize row and column size 
rowsize = 0;
columnsize = 0;

%create a vector for dimension
dimension = 50:1:200;

%validate row and column size inputs by repeating loop until input is valid
while ~any(rowsize == dimension | columnsize == dimension)
    %take user input for row and column size
    rowsize= input('Enter the number of rows:'); 
    columnsize= input('Enter the number of columns:');
end

%specify the dimensions of a matrix and initialize it to 0
mat = zeros(rowsize, columnsize);

%validate input for top row of matrix by repeating loop until input is valid
mat(1,:) = input('Enter the boundary conditions for the top row of the matrix:');
while (mat(1,1) > 255 || mat(1,1) < 0)
    mat(1,:) = input('Enter the boundary conditions for the top row of the matrix:');
end

%validate input for bottom row of matrix by repeating loop until input is valid
 mat(rowsize,:) = input('Enter the boundary conditions for the bottom row of the matrix:');
while (mat(rowsize,1)> 255 || mat(rowsize,1) < 0)
    mat(rowsize,:) = input('Enter the boundary conditions for the bottom row of the matrix: ');
end

%validate input for left column of matrix by repeating loop until input is valid
mat(2:(rowsize-1),1)= input('Enter the boundary conditions for the left column of the matrix: ');
while (mat(2,1) > 255 || mat(2,1) < 0)
    mat(2:rowsize-1,1)= input('Enter the boundary conditions for the left column of the matrix: ');
end

%validate input for right column of matrix by repeating loop until input is valid
 mat(2:(rowsize-1),columnsize)= input('Enter the boundary conditions for the right column of the matrix: ');
while (mat(2,columnsize) > 255 || mat(2,columnsize) < 0)
    mat(2:rowsize-1,columnsize)= input('Enter the boundary conditions for the right column of the matrix: ');
end

%validate input for tolerance value by repeating loop until input is valid
tolerance = input('Enter a tolerance value between 0 and 0.05: ');
while (tolerance > 0.05 || tolerance < 0)
      tolerance = input('Tolerance value is out of range. Please re-enter value: ');
end

%initialize time to 0
t = 0;

%plot the first graph for Heat Dissipation at initial time
subplot(2,2,1)
image(mat) %create graph of matrix as an image
title(['Boundary Conditions at time = ', num2str(t)]) %give title
colormap(jet),colorbar %set color

%plot the second graph for surface contours at initial time
subplot(2,2,2)
contour(mat) %create contour graph
title(['Surface Contour at time = ', num2str(t)]) %give title

%specify the dimensions of matrices and initialize them to 0
newMat = zeros(rowsize, columnsize);
tempdiff = zeros(rowsize, columnsize);

%repeat loop while true
while 1
    %copy mat into newMat
    newMat(2:(rowsize-1),2:(columnsize-1))= mat(2:(rowsize-1),2:(columnsize-1));
    
    %calculate values for each cell in mat
    mat(2:(rowsize-1),2:(columnsize-1))= (mat(2:(rowsize-1),1:(columnsize-2)) + mat(1:(rowsize-2), 2:(columnsize-1)) + mat(2:(rowsize-1),3:columnsize) + mat(3:(rowsize),2:(columnsize-1)))/4;
    
    %calculate the difference between all cells in mat and newMat
    tempdiff(2:(rowsize-1),2:(columnsize-1)) =  mat(2:(rowsize-1),2:(columnsize-1))-newMat(2:(rowsize-1),2:(columnsize-1));
    
    %increment time after every loop
    t = t + 1;
    
    %plot the third graph for Heat Dissipation at final time
    subplot(2,2,3)
    image(mat) %create graph of matrix as an image
    title(['Heat Dissipation at time = ', num2str(t)]) %give title
    colormap(jet),colorbar %set color
    pause(0.00005) %pause
    
    %plot the fourth graph for surface contours at final time
    subplot(2,2,4)
    contour(mat) %create contour graph
    title(['Surface Contour at time = ', num2str(t)]) %give title
    pause(0.00005) %pause
    set(gca, 'ydir', 'reverse') %reverse y axis
    
    %break while loop if all tempdiff values are less than tolerance
    if all(tempdiff < tolerance)
        break;
    end
end
