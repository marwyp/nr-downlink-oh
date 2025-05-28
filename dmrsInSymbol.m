function [re] = dmrsInSymbol(dmrsConfType, dmrsGroupsWithoutData)
    if dmrsConfType == 1
        re = 6;
        assert(ismember(dmrsGroupsWithoutData, [1, 2]));
    elseif dmrsConfType == 2
        re = 4;
    end

    re = re * dmrsGroupsWithoutData;
end

