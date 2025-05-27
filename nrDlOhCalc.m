clearvars; close all;

%% Parameters
% General
numerology = 1;             % 0, 1 or 2 in FR1
bw = 50;                    % bandwidth [MHz]; 5 : 5 : 100

% SSB
nSSB = 4;                   % number of SSB in Burst; 1-8 in FR1
ssbPeriod = 20;             % SSB period [ms]; 5, 10, 20, 40, 80 or 160

% CORESET / PDCCH
coresetDuration = 2;        % duration in symbols; 1, 2 or 3
coresetRBs = 24;            % number of RBs; 6 : 6 : bw
pdcchPeriod = 2;            % PDCCH every k-th slot

% CSI-RS
csirsPeriod = 2;            % CSI-RS every k-th slot
csirsDensity = 3;           % frequence desnsity: 1, 3 or 0.5
csirsNumRb = 5;             % number of resource blocks; 1 : bw
csirsCdmType = "noCDM";     % "noCDM", "FD-CDM2", "CDM-4", "CDM-8"

%% 5G NR Information
% constants
nFrames = 16;               % maximum SSB period
nSubframesPerFrame = 10;

% helper variables
scs = 15 * 2 ^ numerology;
nSlotsPerSubframe = 2 ^ numerology;
nSubframes = 10 * nFrames;
nSlots = nSubframes * nSlotsPerSubframe;
nSymbols = 14 * nSlotsPerSubframe * nSubframes;
nReSymbol = 12 * bw2rb(bw, scs);
nRe = nReSymbol * nSymbols;

%% Parameters validation
assert(ismember(numerology, 0 : 2));
assert(ismember(bw, 5 : 5 : 100));

assert(ismember(nSSB, 1 : 8));
assert(ismember(ssbPeriod, [5, 10, 20, 40, 80, 160]));

assert(ismember(coresetDuration, 1 : 3));
assert(mod(coresetRBs, 6) == 0);
assert(coresetRBs * 12 < nReSymbol);

assert(ismember(csirsDensity, [1, 3, 0.5]));
assert(csirsNumRb * 12 < nReSymbol);
assert(ismember(csirsCdmType, ["noCDM", "FD-CDM2", "CDM-4", "CDM-8"]));

%% OverHead Calculation
% SSB
nSsbSymbolsBurst = 4 * nSSB;
nSsbSymbolsTotal = nSsbSymbolsBurst * nFrames / (ssbPeriod / 10);
nSsbRe = nSsbSymbolsTotal * 240;
ohSsb = nSsbRe / nRe;
disp("SSB OH           = " + ohSsb* 100 + "%");

% CORESET / PDCCH
nPdcchSlots = nSlots / pdcchPeriod;
nPdcchSymbols = nSlots * coresetDuration;
nPdcchRe = nPdcchSymbols * coresetRBs * 12;
ohPdcch = nPdcchRe / nRe;
disp("CORESET/PDCCH OH = " + ohPdcch* 100 + "%");

% CSI-RS
nCsirsSlots = nSlots / csirsPeriod;
nCsirsSymbols = nSlots;
nCsirsRe = nCsirsSymbols * csirsNumRb * csirsDensity ...
    * csrirsCdmToRe(csirsCdmType);
ohCsirs = nCsirsRe / nRe;
disp("CSI-RS OH        = " + ohCsirs * 100 + "%");

% Overall OH
nOhRe = nSsbRe + nPdcchRe + nCsirsRe;
ohTotal = nOhRe / nRe;
disp("Total OH         = " + ohTotal * 100 + "%");
