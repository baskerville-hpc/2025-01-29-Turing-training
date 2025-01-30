import torch
use_cuda = torch.cuda.is_available()

print(f'Is cuda available {use_cuda}')

if use_cuda:
    print('__CUDNN VERSION:', torch.backends.cudnn.version())
    print('__Number CUDA Devices:',
          torch.cuda.device_count())
    for i in range(torch.cuda.device_count()):
        print('__CUDA Device Name:', torch.cuda.get_device_name(i))
        print('__CUDA Device Total Memory [GB]:', torch.cuda.get_device_properties(i).total_memory/1e9)
