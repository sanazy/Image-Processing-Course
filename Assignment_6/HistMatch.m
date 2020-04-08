%% Global Histogram Equalization
function [] = HistMatch()

    mkdir('yalefaces_histeq');
    source = 'yalefaces_histeq\';
    num_people = 15;
    mood_array = {'normal','noglasses','happy','sad','sleepy',...
                  'surprised','wink','centerlight','rightlight','leftlight','glasses'};
    
    for i = 1:num_people
        for j = 1:11
            %% Read images from file
            if i < 10
                s = sprintf('yalefaces_crop/subject0%d.%s',i,mood_array{j});
            else
                s = sprintf('yalefaces_crop/subject%d.%s',i,mood_array{j});
            end
            I = imread(s);
            I = im2double(I);
            
            if j == 1
                %% Use normal image of each person as standard histogram
                NI_eq = histeq(I);
                normal_hist = hist(NI_eq(:), 256);
                %% Write to file
                if i < 10
                    imwrite(NI_eq,[source,'subject0',num2str(i),'.',mood_array{j}],'jpg');
                else
                    imwrite(NI_eq,[source,'subject',num2str(i),'.',mood_array{j}],'jpg');
                end
            else
                %% Use histogram of normal image of each person for histogram equalization 
                g = histeq(I,normal_hist);
                %% Write to a file
                if i < 10
                    imwrite(g,[source,'subject0',num2str(i),'.',mood_array{j}],'jpg');
                else
                    imwrite(g,[source,'subject',num2str(i),'.',mood_array{j}],'jpg');
                end
            end
                        
        end
    end

end
