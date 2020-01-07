%
%
%function PlotTree()
    % read the data 
    NumGen = 10; % Number of generations
    HCTn1 = csvread('HCTn1 for Matlab.csv');
    TIMEPOINTS = csvread('timepoints.csv');
    
    % arrange cell lineage arrays
    CellLineage_ = num2str(HCTn1(:,3),NumGen);
    [HCTn1_Rnum, HCTn1_Cnum] = size(HCTn1);
    CellLineage = strings(HCTn1_Rnum,1);
    for i = 1:HCTn1_Rnum
       CellLineage(i) = replace(CellLineage_(i,:),'.','');
       CellLineage(i) = replace(CellLineage(i),' ','');
    end
    
    