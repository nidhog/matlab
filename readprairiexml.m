function outstruct=readprairiexml(filename,firstframeonly)

% outstruct=readprairiexml(filename_or_dir,[firstframeonly=1])
%
% Reads PrairieView XML file, returns structure containing the name/value pairs of the
% FIRST imaging frame.
%
% To output data from all frames (may be slow), set firstframeonly =0;
%
% Generally, we only want the first frame info because its usually the same throughout,
% but this function could easlily be extended to get more.
%
% Gordon Smith, Dec 2011

if nargin<2
    firstframeonly=true;
end
%%
% if isempty(strfind(filename,'.xml'))
%     filename2=[filename filesep filename '.xml'];
%     if ~isempty(dir(filename2))
%         filename=filename2;
%     else
%         filename2=[filename '-001' filesep filename '-001.xml'];
%         if ~isempty(dir(filename2))
%             filename=filename2;
%         else
%             error('No xml file found.')
%         end
%     end
% end


%%
xdoc=xmlread(filename);

a=xdoc.getChildNodes;
node=a.item(0); %first Node, PVScan
children = node.getChildNodes;
nchildren = children.getLength;
for i = 1:nchildren
    child = children.item(i-1);
    if strcmp('Sequence',char(child.getNodeName)); %find sequence, usu i=4;
        seq=child;
        break
    end
end

nframe=1;

childrenf = seq.getChildNodes;
nchildrenf = childrenf.getLength;
for i = 1:nchildrenf
    child = childrenf.item(i-1);
    if strcmp('Frame',char(child.getNodeName)); %find first frame, usu i=2;
        outstruct(nframe)=getoutputdata(child);
        if firstframeonly
            break
        end
        nframe=nframe+1;
    end
end

function tempstruct=getoutputdata(fr)
% Get the actual data
tempstruct=[];
childrenp = fr.getChildNodes;
nchildrenp = childrenp.getLength;
for i = 1:nchildrenp
    child = childrenp.item(i-1);
    if strcmp('PVStateShard',char(child.getNodeName)); %find first frame, usu i=2;
        pv=child;
        break
    end
end

childrenk = pv.getChildNodes; %children here are the individual lines, denoted by Key
nchildrenk = childrenk.getLength;
for i = 1:nchildrenk
    child = childrenk.item(i-1);
    %
    if child.hasAttributes %attributes here are the name/permission/value triplets
        attributes=child.getAttributes;
        nattr = attributes.getLength;
        for j = 1:nattr
            attr = attributes.item(j-1);
            if strcmp('key', char(attr.getName)) %if its a name
                fn=char(attr.getValue);
            elseif strcmp('value', char(attr.getName)) %if its a value (ignore permissions)
                v=char(attr.getValue);
                if ~isempty(str2num(v))
                    v=str2num(v);
                end
            end
        end
        tempstruct.(fn)=v;
    end
end
