function [data, label, name] = getInformation(path, labelsssss)
    files = dir(path);
    file_len = length(files);
    data = zeros(file_len - 2, 300*300);
    label = zeros(file_len - 2, 1);
    name = cell(file_len - 2, 1);
    j = 1;
    for i = 1 : file_len
        file_name = files(i).name;
        if ~strcmp(file_name, '.') & ~strcmp(file_name, '..')
            file_path = [path '\' file_name];
            pano_view = get_panoview(file_path);
            % because the size can be changed. After analysis, we apply 300
            % as the final size.
            pano_view = pano_view(:, 1 : 300);
            pano_view = reshape(pano_view, 1, 300*300);
            pano_view = double(pano_view);
            data(j,:) = pano_view;
            label(j,1) = labelsssss;
            name{j,1} = file_name;
            j = j + 1;
        end
    end
end