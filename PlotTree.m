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
        absTimePointG1(j) =  HCTn1(j,10)+ Cum1(j);
    end
    % calculate absolute time points for G2
    Cum2 = zeros(1,HCTn1_Rnum);
    for k = 1:HCTn1_Rnum
        if (HCTn1(k,11) > 1)
          Cum2(k) = sum(TIMEPOINTS(1:HCTn1(k,11)-1));
        end
        absTimePointG2(k) =  HCTn1(k,15)+ Cum2(k);
    end
    % calculate absolute time points for NEBD
    Cum3 = zeros(1,HCTn1_Rnum);
    for l = 1:HCTn1_Rnum
        if (HCTn1(l,11) > 1)
          Cum3(l) = sum(TIMEPOINTS(1:HCTn1(l,11)-1));
        end
        absTimePointNEBD(l) =  HCTn1(l,16)+ Cum3(l);
    end
     % calculate absolute time points for Ao
    Cum4 = zeros(1,HCTn1_Rnum);
    for m = 1:HCTn1_Rnum
        if (HCTn1(m,11) > 1 & HCTn1(m,17) ~= 0)
          Cum4(m) = sum(TIMEPOINTS(1:HCTn1(m,11)-1));
        end
        absTimePointAo(m) =  HCTn1(m,17)+ Cum4(m);
    end
    
    % draw start-Ao for parent cells
    for n = 1:HCTn1_Rnum
        if(strlength(CellLineage(n))==1)
            line([0 absTimePointAo(n)],[n n],'Color','r','LineWidth',3);
        end
    end
    
    % draw Ao-Ao for children cells
    for nn = 1:HCTn1_Rnum
        if(strlength(CellLineage(nn)) > 1)
            ShortenLineage_ = extractBefore(CellLineage(nn),strlength(CellLineage(nn)));
            for mm = 1:HCTn1_Rnum
                if(strcmp(ShortenLineage_,CellLineage(mm))&& absTimePointAo(nn)==0)
                  line([absTimePointAo(mm) absTimePointAo(nn)],[nn nn],'Color','k','LineWidth',1,'LineStyle',':');
                elseif(strcmp(ShortenLineage_,CellLineage(mm))&& absTimePointAo(nn)~=0)
                  line([absTimePointAo(mm) absTimePointAo(nn)],[nn nn],'Color','k','LineWidth',3);
                end
            end
        end
    end
    
    % draw branches at Ao
    hold on;
    x = 1:HCTn1_Rnum;
    plot(absTimePointNEBD,x,'r.'); % plot NEBD points
    for ll = 1:HCTn1_Rnum 
       %if(absTimePointAo(ll) ~= 0 && strlength(CellLineage(ll))>0)
       if(strlength(CellLineage(ll))>0)
         ShortenLineage = extractBefore(CellLineage(ll),strlength(CellLineage(ll)));
         for mmm = 1:HCTn1_Rnum
            if(strcmp(ShortenLineage,CellLineage(mmm)))
              line([absTimePointAo(mmm) absTimePointAo(mmm)],[mmm ll],'LineWidth',1);
            end
         end
       end
    end

    % mark death
       DeathIdx = find(HCTn1(:,18));
       [size_Didx ~] = size(DeathIdx);
       DidxPosition = -100*ones(size_Didx);
       plot(DidxPosition,DeathIdx,'^','color','k');
    % mark lost
       LostIdx = find(HCTn1(:,19));
       [size_Lidx ~] = size(LostIdx);
       LidxPosition = -100*ones(size_Lidx);
       plot(LidxPosition,LostIdx,'o','color','b');
     % mark Survive
       SurIdx = find(HCTn1(:,20));
       [size_Sidx ~] = size(SurIdx);
       SidxPosition = -100*ones(size_Sidx);
       plot(SidxPosition,SurIdx,'*','color','r');
  
    %  Graph settings
       legend('* survive','o lost','triangle death','. NEBD');
       grid on; ylabel('Cell #'); xlabel('time');
       axis_r = axis;  axis_r(1) = -200;  axis(axis_r);  
       set(gca,'YDIR','reverse');title('Lineage for Ao-Ao');
       