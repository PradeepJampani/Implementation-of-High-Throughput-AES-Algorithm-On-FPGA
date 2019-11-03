clear;
sample_rate =150e6; 
ts=1/sample_rate;

data = [50, 67, 246, 168, 136, 90, 48, 141, 49, 49, 152, 162, 224, 55, 7, 52]';
 
keyi = [27, 128, 26,25, 44, 173, 230, 167, 171, 247, 27, 136, 91, 207, 79, 60]';

data1 = [50, 67, 246, 168, 136, 90, 48, 141, 49, 49, 152, 162, 224, 55, 7, 52]';
 
keyi1 = [27, 125, 21,22, 40, 174, 210, 166, 171, 247, 21, 136, 9, 207, 79, 60]';


t = [0:15]'/sample_rate;

for i = 1:16
   inp(i).time = t(i,:)';
   inp(i).signals.values = data(i,:)';
   inp(i).signals.dimensions = 1;

end


for i = 1:16
   key(i).time = t(i,:)';
   key(i).signals.values = keyi(i,:)';
   key(i).signals.dimensions = 1;

end

for i = 1:16
   inp1(i).time = t(i,:)';
   inp1(i).signals.values = data(i,:)';
   inp1(i).signals.dimensions = 1;

end


for i = 1:16
   key1(i).time = t(i,:)';
   key1(i).signals.values = keyi(i,:)';
   key1(i).signals.dimensions = 1;

end



BlockName = 'unrolled_pipelined_parallel';


set_param([BlockName '/From Workspace'],'VariableName','inp(1)')
set_param([BlockName '/From Workspace16'],'VariableName','key(1)')
set_param([BlockName '/From Workspace32'],'VariableName','inp1(1)')
set_param([BlockName '/From Workspace48'],'VariableName','key1(1)')


for i=1:15
    set_param([BlockName '/From Workspace' num2str(i)],'VariableName',['inp(' num2str(i+1) ')'])
    set_param([BlockName '/From Workspace' num2str(i+16)],'VariableName',['key(' num2str(i+1) ')'])
    
  set_param([BlockName '/From Workspace' num2str(i+32)],'VariableName',['inp1(' num2str(i+1) ')'])
    set_param([BlockName '/From Workspace' num2str(i+48)],'VariableName',['key1(' num2str(i+1) ')'])
 
end
set_param([BlockName '/To Workspace'],'VariableName','cipher')

set_param([BlockName '/To Workspace'],'SaveFormat',['Structure With Time'])