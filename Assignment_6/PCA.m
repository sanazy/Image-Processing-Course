%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% * Histogram Equalization based on the standard image was done to increase
%   the accuracy and eliminate the effect of the nonuniform illumination
% * Cropped Images of faces of people in dataset was used to increase 
%   final accuracy, for see the result of the exact dataset you can change 
%   the directory
% * Cropped Images also attached with this assignment
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [] = PCA()

    %% Features of dataset
    num_people = 15;
    mood_array = {'normal','noglasses','happy','sad','sleepy','wink'...
                  'surprised','glasses','centerlight','rightlight','leftlight'};
              
    %% Train System         
    avg = zeros([243,185]);
    std = zeros([243,185]);
    N = 0;
    for j = 1:8
        for i = 1:num_people
            N = N + 1;
            if i < 10
                s = sprintf('yalefaces_histeq/subject0%d.%s',i,mood_array{j});
            else
                s = sprintf('yalefaces_histeq/subject%d.%s',i,mood_array{j});
            end
            f = imread(s);
            I = f;
            I = im2double(I);
            I = imresize(I,[243,185]);
            avg = avg + I;
            std = std + I.^2;
            I = I(:);
            A(:,N) = I;
        end
    end

    %% Calculate Avearage & Std Imgae
    avg = avg / N;
    std = sqrt(std/N - avg.^2); %approximation to std
    figure; imshowpair(avg,std,'montage'); title('Average Face                 Standard deviation');
    avg = avg(:);
    std = std(:);
    
    
    %% Normalize Images
    for i = 1 : N
       A(:,i) = (A(:,i) - avg) ./ std; 
    end
    
    Z = (1/N)* (A)' * A; 
    
    %% Reduce dimension & ignore very small eigen values
    selected_dim = 25;
    [V,E] = eigs(Z,selected_dim);%sorted eigen values
    
    %% Compute eigen faces
    Q = A * V;
    
    %% Show eigenFaces
    h = ceil(sqrt(selected_dim));
    figure;
    for i = 1 : selected_dim
        subplot(h,h,i); imshow(reshape(Q(:,i),[243,185]),[]);title(num2str(E(i,i)));
    end
    
    %% Calculate K Vector for each Person
    for i = 1:num_people
        for j = 1:11
            if i < 10
                s = sprintf('yalefaces_histeq/subject0%d.%s',i,mood_array{j});
            else
                s = sprintf('yalefaces_histeq/subject%d.%s',i,mood_array{j});
            end
            x = imread(s);
            I = im2double(x);
            I = imresize(I,[243,185]);
            k_eachone(j,:) = I(:)' * Q;   
        end
        %% Pooling
        mean_k(i,:) = mean(k_eachone);
    end
    
    all = 0;
    correct = 0;
    conf_matrix = zeros(num_people,num_people);
    
    for i = 1:num_people
        for j = 1:11
            if i < 10
                s = sprintf('yalefaces_histeq/subject0%d.%s',i,mood_array{j});
            else
                s = sprintf('yalefaces_histeq/subject%d.%s',i,mood_array{j});
            end
            f = imread(s);
            I = im2double(f);
            I = imresize(I,[243,185]);
            k_test = (I(:))' * Q;

            for k = 1:num_people
               dist(k) = norm (k_test - mean_k(k,:)); 
            end
            [min_val, min_index] = min(dist(1:end));
            %% Use all and correct variables to measure the accuracy
            all = all + 1;
            if i == min_index
                correct = correct + 1; 
            else
                fprintf('subject "%d.%s" -> subject "%d"\n',i,mood_array{j},min_index);
            end
            conf_matrix(i,min_index) = conf_matrix(i,min_index) + 1;
        end
    end
    
    %% Compute accuracy & show confusion matrix
    accuracy = (correct/all)*100;
    fprintf('Accuracy = %f\n',accuracy);
    figure; imagesc(conf_matrix); colormap(flipud(gray)); title ('Confusion Matrix');
    
    %% Detect hardest example for system
    diag_mtx = conf_matrix .* eye(num_people);
    wrong_hit = sum(conf_matrix - diag_mtx);
    miss_rate = sum(conf_matrix - diag_mtx,2);
    figure; 
    subplot(1,2,1);bar((1:num_people),miss_rate');title('Miss Rate');
    xlabel('People ID'); ylabel('Miss Rate');
    subplot(1,2,2); bar((1:num_people),wrong_hit,'r'); title('Chosen Wrongly');
    xlabel('People ID'); ylabel('Wrong Hit Rate');
    
end