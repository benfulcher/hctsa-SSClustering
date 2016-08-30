clear all;

load('HCTSA_N.mat');

for i = 1:length(TimeSeries)
    csvwrite(['./tsTxtFiles/ts_',num2str(i),'.txt'],TimeSeries(i).Data);
end