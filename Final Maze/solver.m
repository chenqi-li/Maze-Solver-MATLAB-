%Final Maze
%Load the image
Original = imread('maze-.png');

%Convert to grayscale
Toys = rgb2gray(Original);
Toys = 255*(Toys>100);

%Identify the number of rows and columns
[r,c] = size(Toys);

Toys_Filled = ones(r,c).*255;

%Narrowing the maze down to one single line
count = 1;
while count<4
    count = count+1
for a = 1:r
    disp(a)
    for b = 1:c
        %Identify the neighbors
        Neighbors = Toys(max(1,a-1):min(a+1,r),max(1,b-1):min(b+1,c));
        %Identify the number of white neighbors
        No_of_White = sum(sum(Neighbors~=0));
        %Identify the number of black neighbors
        No_of_Black = sum(sum(Neighbors~=255));
        %If any element is surrounded purely by white neighbors, it means
        %the matrix has more filling to do
        if No_of_White == 9
            for d = 1:r
                for e = 1:c
                    %Identify all the black elements and fill their
                    %neighbors
                    if Toys(d,e) == 0
                        Toys_Filled(max(1,d-1):min(d+1,r),max(1,e-1):min(e+1,c))=0;
                    end
                end
            end
        end
    end
end
Toys = Toys_Filled
end

%%
%Worked

%Dead end filling
[C,R] = size(Toys_Filled);

count = 1;
while count < 500
    count = 1+count
    for y = 1:R
        for x = 1:C
            if x-1==0 && x+1<=C && y-1==0 && y+1<=R
                XY = Toys_Filled(x,y);
                VN = [Toys_Filled(x+1,y)];
                HN = [Toys_Filled(x,y+1)];
                NoOf0VN = sum(VN(:)==0);
                NoOf0HN = sum(HN(:)==0);
            elseif x+1>C && x-1>0 && y-1==0 && y+1<=R
                XY = Toys_Filled(x,y);
                VN = [Toys_Filled(x-1,y)];
                HN = [Toys_Filled(x,y+1)];
                NoOf0VN = sum(VN(:)==0);
                NoOf0HN = sum(HN(:)==0);
            elseif y+1>R && y-1>0 && x+1<=C && x-1==0
                XY = Toys_Filled(x,y);
                VN = [Toys_Filled(x+1,y)];
                HN = [Toys_Filled(x,y-1)];
                NoOf0VN = sum(VN(:)==0);
                NoOf0HN = sum(HN(:)==0);
            elseif x-1>0 && y-1>0 && x+1>C && y+1>R
                XY = Toys_Filled(x,y);
                VN = [Toys_Filled(x-1,y)];
                HN = [Toys_Filled(x,y-1)];
                NoOf0VN = sum(VN(:)==0);
                NoOf0HN = sum(HN(:)==0);
            elseif x+1<=C && x-1>0 && y+1>R && y-1>0
                XY = Toys_Filled(x,y);
                VN = [Toys_Filled(x-1,y),Toys_Filled(x+1,y)];
                HN = [Toys_Filled(x,y-1)];
                NoOf0VN = sum(VN(:)==0);
                NoOf0HN = sum(HN(:)==0);
            elseif x+1>C && x-1>0 && y+1<=R && y-1>0
                XY = Toys_Filled(x,y);
                VN = [Toys_Filled(x-1,y)];
                HN = [Toys_Filled(x,y+1), Toys_Filled(x,y-1)];
                NoOf0VN = sum(VN(:)==0);
                NoOf0HN = sum(HN(:)==0);
            elseif x+1<=C && x-1>0 && y+1<=R && y-1==0
                XY = Toys_Filled(x,y);
                VN = [Toys_Filled(x+1,y),Toys_Filled(x-1,y)];
                HN = [Toys_Filled(x,y+1)];
                NoOf0VN = sum(VN(:)==0);
                NoOf0HN = sum(HN(:)==0);
            elseif x+1<=C && x-1==0 && y+1<=R && y-1>0
                XY = Toys_Filled(x,y);
                VN = [Toys_Filled(x+1,y)];
                HN = [Toys_Filled(x,y+1),Toys_Filled(x,y-1)];
                NoOf0VN = sum(VN(:)==0);
                NoOf0HN = sum(HN(:)==0);
            elseif x+1<=C && x-1>0 && y+1<=R && y-1>0
                XY = Toys_Filled(x,y);
                VN = [Toys_Filled(x+1,y),Toys_Filled(x-1,y)];
                HN = [Toys_Filled(x,y+1),Toys_Filled(x,y-1)];
                NoOf0VN = sum(VN(:)==0);
                NoOf0HN = sum(HN(:)==0);
            end
                if NoOf0VN == 2 && NoOf0HN == 1
                    Toys_Filled(x,y) = 0;
                elseif NoOf0VN == 1 && NoOf0HN == 2
                    Toys_Filled(x,y) = 0;
                end
        end
    end
end

%Create a 3d matrix to prepare for rgb colored solution
Toys_Solution = zeros(C,R,3);

%Make the white values a max value of the color
Toys_Solution(:,:,2) = Toys_Filled

%Subtract the two to combine the original maze with the solution
Toys_Answer = Toys-Toys_Solution

imshow(Toys_Answer)
