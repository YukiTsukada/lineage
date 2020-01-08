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
    
    % calculate absolute time points for G1
    Cum1 = zeros(1,HCTn1_Rnum);
    for j = 1:HCTn1_Rnum
        if (HCTn1(j,1) > 1)
          Cum1(j) = sum(TIMEPOINTS(1:HCTn1(j,1)-1));
        end
        absTimPointG1(j) =  HCTn1(j,10)+ Cum1(j);
    end
    % calculate absolute time points for G2
    Cum2 = zeros(1,HCTn1_Rnum);
    for k = 1:HCTn1_Rnum
        if (HCTn1(k,11) > 1)
          Cum2(k) = sum(TIMEPOINTS(1:HCTn1(k,11)-1));
        end
        absTimPointG2(k) =  HCTn1(k,15)+ Cum2(k);
    end
    % calculate absolute time points for NEBD
    Cum3 = zeros(1,HCTn1_Rnum);
    for l = 1:HCTn1_Rnum
        if (HCTn1(l,11) > 1)
          Cum3(l) = sum(TIMEPOINTS(1:HCTn1(l,11)-1));
        end
        absTimPointNEBD(l) =  HCTn1(l,16)+ Cum3(l);
    end
     % calculate absolute time points for A0
    Cum4 = zeros(1,HCTn1_Rnum);
    for m = 1:HCTn1_Rnum
        if (HCTn1(m,11) > 1)
          Cum4(m) = sum(TIMEPOINTS(1:HCTn1(l,11)-1));
        end
        absTimPointA0(m) =  HCTn1(m,17)+ Cum4(m);
    end
    

    
    
    
    