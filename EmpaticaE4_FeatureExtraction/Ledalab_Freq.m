function [SCRFrequency] = Ledalab_Freq(EdaSignal, fs, ledalab_dir)
cd(ledalab_dir)
LedalabTempDir = ledalab_dir + "/ledalabtempfiles";
Timings = [1:length(EdaSignal)]'*(1/fs);
fn="/TempEdaSignal.txt";
ConvertToLedalabTextInput([Timings EdaSignal],fullfile(LedalabTempDir,fn));

l=LedalabTempDir+"/TempEdaSignal.txt";
LedalabTempDirplusfile=char(l);
Ledalab(LedalabTempDirplusfile, 'open', 'text', 'downsample',0,'export_scrlist',[0.005 1],'optimize',1);
% derive SCR metrics
ff=LedalabTempDir+"/TempEdaSignal_scrlist.mat";
ff2=char(ff);
load(ff2);
SCRLocations = round(scrList.TTP.onset/(1/fs));
SCRAmplitudes = scrList.TTP.amp;
SCRFrequency=length(SCRLocations)/(length(EdaSignal)*(1/fs)/60);

end