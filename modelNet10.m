%%%%%%%%%%%%%%%%%%
% This file is to read the panoview data od ModelNet.
clear
clc
% the path of the data
data_path = 'D:\dataset\ModelNet\ModelNet10';
% get the classes under the path
class_files = dir(data_path);
% get the number of classes 
class_len = length(class_files);
% creat empty array to store data
traindata = zeros(0, 300*300);
trainlabel = zeros(0, 1);
trainname = cell(0, 1);

testdata = zeros(0, 300*300);
testlabel = zeros(0, 1);
testname = cell(0, 1);

train_len = zeros(class_len - 2, 1);
test_len = zeros(class_len - 2, 1);
for class = 1 : class_len
    % get the class names
    class_name = class_files(class).name;
    %
    if ~strcmp(class_name, '.') & ~strcmp(class_name, '..')
        % add the class name to the path
        typePath = [data_path '\' class_name];
        type_files = dir(typePath);
        type_len = length(type_files);
        for ty = 1 : type_len
            type_name = type_files(ty).name;
            if strcmp(type_name, 'test')
                test_path = [typePath '\' type_name];
                [data, label, name] = getInformation(test_path, class - 3);
                testdata = [testdata; data];
                testlabel = [testlabel; label];
                testname = [testname; name];
                test_len(class -2, 1) = length(label);
            end
            if strcmp(type_name, 'train')
                train_path = [typePath '\' type_name];
                [data, label, name] = getInformation(train_path, class - 3);
                traindata = [traindata; data];
                trainlabel = [trainlabel; label];
                trainname = [trainname; name];
                train_len(class -2, 1) = length(label);
            end
        end
    end
    disp('------------------- class done!')
    disp(class_name)
end

save traindata.mat traindata trainlabel trainname train_len -v7.3
save testdata.mat testdata testlabel testname test_len -v7.3
disp('------------------- Done!')