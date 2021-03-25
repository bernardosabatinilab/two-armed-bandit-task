function setupLogging(logName)
    global logFileID
    global info
    baseName = [logName, '_', int2str(yyyymmdd(datetime)), '_'];
    fileCounter = 1;
    fName = [baseName, int2str(fileCounter), '.csv'];
    while (exist(fName, 'file'))
        fileCounter = fileCounter + 1;
        fName = [baseName, int2str(fileCounter), '.csv'];
    end
    %gets FileName and PathName from info global struct (GUI)
    FileName = fName;
    PathName = info.folderName;
    fName = fullfile(PathName,FileName);
    logFileID = fopen(fName, 'w');
end
