%% Global Histogram Equalization
function [] = CROP()
    
    source = 'D:\Matlab\Sanaz_Examples\ImageSP\New_6\yalefaces3\';
    num_people = 15;
    mood_array = {'normal','noglasses','happy','sad','sleepy','surprised',...
                  'wink','centerlight','rightlight','leftlight','glasses'};
    
    for i = 15:num_people
        for j = 1:11
            
            if i < 10
                s = sprintf('yalefaces/subject0%d.%s',i,mood_array{j});
            else
                s = sprintf('yalefaces/subject%d.%s',i,mood_array{j});
            end
            I = imread(s);
            g = imcrop(I);

            if i < 10
                imwrite(g,[source,'subject0',num2str(i),'.',mood_array{j}],'jpg');
            else
                imwrite(g,[source,'subject',num2str(i),'.',mood_array{j}],'jpg');
            end
            
        end
    end
    
end
