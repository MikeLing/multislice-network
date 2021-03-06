%%输出每个节点对的mat文件 作为基础样本

function  smp=outPutSamples(sorted,sampleMat,sliceSize,sum_adj_mat)%slicesize表示一个sample的维度
    smp=[];
    
    for i=1:length(sorted)
       node=[];%对应节点
       node=sorted(i,:);
       otp=[];
       for t=1:length(sampleMat)           
            otp(t)=sampleMat{t}(node(1),node(2)); 
       end
       smp(i,:)=otp;
       eachSample=[];
       for m=1:(length(smp)-sliceSize)
            for n=1:sliceSize
                if n==sliceSize
                    eachSample(m,n)=sum_adj_mat{n+m-1}(node(1),node(2));%这里第sliceSize列为label
                else
                    eachSample(m,n)=smp(1,m+n-1);
                end                
            end           
       end 
       label=eachSample(:,sliceSize);
       eachSample=eachSample(:,randperm(sliceSize-1));
       eachSample(:,sliceSize)=label;
       train_set_x=eachSample(:,1:end-1);
       train_set_y=eachSample(:,end);
       test_count = round(0.75*size(eachSample,1));
       valid_count = round(0.5*size(eachSample,1));
       test_set_x=eachSample((test_count+1):end,1:end-1);%75%-100%为测试机
       test_set_y=eachSample((test_count+1):end,end);
       valid_set_x=eachSample((valid_count+1):(test_count+1),1:end-1);%50%-75%为验证机
       valid_set_y=eachSample((valid_count+1):(test_count+1),end);
    save(['INFO_LP_SliceSize_',num2str(sliceSize),'_FINDL_node_',num2str(node(1)),'_',num2str(node(2)),'.mat'],'train_set_x','train_set_y','test_set_x','test_set_y','valid_set_x','valid_set_y'); %save file
    end
    