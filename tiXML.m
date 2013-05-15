% get times from (non-triggered) 2P without showing figure
xmlFileName = uigetfile('*.xml')
[P, S, stimOn, stimID, ST, M] = getTimesXML(0, xmlFileName);
