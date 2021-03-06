%{
    
    pathchange.m -- function for switching the internal reference to
    'paths.mat'. <name> is expected to be the fieldname of a path defined
    in 'global_paths.mat', and the associated path must have a 'paths'
    subdirectory, with a 'paths.mat' file within.

%}

function pathchange(name)

persistent oldname;

if strcmp(oldname,name)
    fprintf('\n''paths.m'' already refers to %s\n\n',name);
    return;
end

pathstr = pathfor(name);
pathstr = fullfile(pathstr,'paths');

validate(pathstr);  %   make sure the path to add / remove is a real path

addpath(pathstr);

if ~isempty(oldname)
    rmpath(fullfile(pathfor(oldname),'paths'));
end

oldname = name;

fprintf('\n''paths.m'' now refers to %s\n\n',name);

end

function validate(direc)

start = cd;

try 
    cd(direc);
catch
    error('The path %s does not exist',direc);
end

cd(start);

end
