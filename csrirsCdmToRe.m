function [re] = csrirsCdmToRe(cdmType)
    if cdmType == "noCDM"
        re = 1;
    elseif cdmType == "FD-CDM2"
        re = 2;
    elseif cdmType == "CDM-4"
        re = 4;
    elseif cdmType == "CDM-8"
        re = 8;
    end
end

