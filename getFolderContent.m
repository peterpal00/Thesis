function [content] = getFolderContent(path)

    dirvariable = dir(path);
    content = strings(length(dirvariable)-2, 1);
    
    for i = 3: length(dirvariable)
        content(i-2) = fullfile(dirvariable(i).folder, dirvariable(i).name);
    
    end
end