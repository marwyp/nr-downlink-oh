function [rb] = bw2rb(bw, scs)
    % TS 38.101 Table 5.3.2-1
    % bw - bandwidth in MHz
    % scs - subcarrier spacing in kHz

    if scs == 15
        if ~ismember(bw, 5 : 5 : 50)
            error("Wrong BW configuration!")
        end
        rb = [25 52 79 106 133 160 188 216 242 270];
    elseif scs == 30
        if ~ismember(bw, [5 : 5 : 50, 60 : 10 : 100])
            error("Wrong BW configuration!")
        end
        rb = [11 24 38 51 65 78 92 106 119 133 162 189 217 245 273];
    elseif scs == 60
        if ~ismember(bw, [10 : 5 : 50, 60 : 10 : 100])
            error("Wrong BW configuration!")
        end
        rb = [-1 11 18 24 31 38 44 51 58 65 79 93 107 121 135];
    end
    if bw <= 50
        rb = rb(bw / 5);
    else
        rb = rb(10 + (bw - 50) / 10);
    end
end

