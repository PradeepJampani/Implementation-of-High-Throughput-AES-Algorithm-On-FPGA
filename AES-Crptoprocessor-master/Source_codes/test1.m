clear;
sample_rate =250e6; % Sample rate to give the time period . Change this for different implementations to make the value zero 
ts=1/sample_rate;

data = [20, 33, 129, 158, 116, 91, 44, 121, 42, 39, 142, 122, 232, 53, 72, 53]';
 
keyi = [27, 128, 26,25, 44, 173, 230, 167, 171, 247, 27, 136, 91, 207, 79, 60]';



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



BlockName ='folded_pipelined_test';


set_param([BlockName '/From Workspace'],'VariableName','inp(1)')
set_param([BlockName '/From Workspace16'],'VariableName','key(1)')


for i=1:15
    set_param([BlockName '/From Workspace' num2str(i)],'VariableName',['inp(' num2str(i+1) ')'])
    set_param([BlockName '/From Workspace' num2str(i+16)],'VariableName',['key(' num2str(i+1) ')'])
  
 
end
set_param([BlockName '/To Workspace'],'VariableName','cipher')

set_param([BlockName '/To Workspace'],'SaveFormat',['Structure With Time'])