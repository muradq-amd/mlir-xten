#loc = loc(unknown)
module attributes {
  llvm.data_layout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128",
  llvm.target_triple = "x86_64-unknown-linux-gnu",
  "onnx-mlir.symbol-postfix" = "onnxmodel.onnx.mlir",
  vaimlconf.device = "Stx",
  vaimlconf.device_models = "${vaimlconf.install_dir}/data/deviceModels",
  vaimlconf.install_dir = "/proj/aiebuilds/ryzen-ai/ryzen-ai-TA/main/ryzenai_1.4.0_2025_01_21_3246/lnx64/lib/python3.10/site-packages/flexml/flexml_extras",
  vaimlconf.library_metadata = ["${vaimlconf.install_dir}/data/libraryMetadata/L1", "${vaimlconf.install_dir}/data/libraryMetadata/L2", "${vaimlconf.install_dir}/../../vitis_mllib/L1/metadata", "${vaimlconf.install_dir}/../../vitis_mllib/L2/metadata"]} {

func.func private @forward(%arg0: tensor<1x3x224x224xbf16> loc(unknown)) -> tensor<1x1x1000xbf16> {
 %0 = xten_nn.load_external_const {file = "constants.h5", key = "/conv1/Conv/biases"} -> tensor<64xbf16> loc(#loc69)
 %41 = xten_nn.load_external_const {file = "constants.h5", key = "/fc/Gemm/Constant_1_0"} -> tensor<1x512x1000xbf16> loc(#loc)
 
 %42 = xten_nn.subgraph (%arg1 = %arg0: tensor<1x3x224x224xbf16>, %arg3 = %0: tensor<64xbf16>)  attributes {
   IfmOperands = [0 : index],
   LayerName = "/conv1/Conv",
   Operands = [
     {
       CurrentDataFormat = "NCHW",
       L3DataFormat = "HCWN",
       L3Vectorization = "C:4",
       l1_extend_end = dense<[0, 1, 0, 0]> : vector<4xindex>
     },
     {
       l1_extend_end = dense<[0, 1, 0, 0]> : vector<4xindex>,
       l1_extend_start = dense<0> : vector<4xindex>,
       l1_fullbroadcast = dense<-1> : vector<2xindex>
     },
     {
     }
   ],
   OutputName = "/relu/Relu",
   Overlay = "4x4_1x4_vertBroadcastLeft_horizBroadcastRight",
   Reason = "InCoreChain",
   Results = [
     {
       CurrentDataFormat = "NCHW",
       L3DataFormat = "HCWN",
       L3Vectorization = "C:8",
       l1_extend_end = dense<0> : vector<4xindex>,
       l1_extend_start = dense<0> : vector<4xindex>
     }
   ],
   estimation = {
     buffer_cycles = {ifm = 42840 : ui64, ofm = 50456 : ui64, wts = 1882 : ui64},
     computation_cycles = 70819 : ui64,
     cycle_count = 283276 : ui64
   },
   herd_size = dense<4> : vector<2xindex>,
   l1_tile_permute = dense<[2, 1, 3, 4, 0]> : vector<5xindex>,
   memory_configuration = {
     L1 = {layout = "strict"},
     L2 = {feature_maps_buffering = "double", layout = "flexible"}
   }} {
   %zeros = tensor.empty(): tensor<1x64x112x112xbf16> loc(#loc71)
   xten_nn.output %zeros: tensor<1x64x112x112xbf16> 
  } -> tensor<1x64x112x112xbf16> loc(#loc71)

  %43 = xten_nn.subgraph (%arg1 = %arg0: tensor<1x3x224x224xbf16>, %arg3 = %0: tensor<64xbf16>)  attributes {
    IfmOperands = [0 : index],
    LayerName = "/conv1/DummyConv1",
    Operands = [ {} ],
    OutputName = "/relu/Relu",
    Overlay = "4x4_1x4_vertBroadcastLeft_horizBroadcastRight",
    Reason = "InCoreChain",
    Results = [{ }],
    estimation = { 
    } } {
    %zeros = tensor.empty(): tensor<1x64x112x112xbf16> loc(#loc71)
    xten_nn.output %zeros: tensor<1x64x112x112xbf16> 
  } -> tensor<1x64x112x112xbf16> loc(#loc71)

  %44 = xten_nn.subgraph (%arg1 = %arg0: tensor<1x3x224x224xbf16>, %arg3 = %0: tensor<64xbf16>)  attributes {
    IfmOperands = [0 : index],
    LayerName = "/conv1/DummyConv2",
    Operands = [ {} ],
    OutputName = "/relu/Relu",
    Overlay = "4x4_1x4_vertBroadcastLeft_horizBroadcastRight",
    Reason = "InCoreChain",
    Results = [{ }],
    estimation = { 
    } } {
    %zeros = tensor.empty(): tensor<1x64x112x112xbf16> loc(#loc71)
    xten_nn.output %zeros: tensor<1x64x112x112xbf16> 
  } -> tensor<1x64x112x112xbf16> loc(#loc71)
    %76 = tensor.empty() : tensor<1x1x1000xbf16> loc(#loc68)
    return %76 : tensor<1x1x1000xbf16> loc(#loc70)
  }
}     

#loc1 = loc("/conv1/Conv")
#loc2 = loc("/relu/Relu")
#loc3 = loc("/maxpool/MaxPool")
#loc4 = loc("Initializer_onnx::Conv_197")
#loc5 = loc("/layer1/layer1.0/conv1/Conv")
#loc6 = loc("/layer1/layer1.0/relu/Relu")
#loc7 = loc("Initializer_onnx::Conv_200")
#loc8 = loc("/layer1/layer1.0/conv2/Conv")
#loc9 = loc("/layer1/layer1.0/Add")
#loc10 = loc("/layer1/layer1.0/relu_1/Relu")
#loc11 = loc("Initializer_onnx::Conv_203")
#loc12 = loc("Initializer_onnx::Conv_206")
#loc13 = loc("/layer1/layer1.1/conv1/Conv")
#loc14 = loc("/layer1/layer1.1/relu/Relu")
#loc15 = loc("/layer1/layer1.1/conv2/Conv")
#loc16 = loc("/layer1/layer1.1/Add")
#loc17 = loc("/layer1/layer1.1/relu_1/Relu")
#loc18 = loc("Initializer_onnx::Conv_209")
#loc19 = loc("/layer2/layer2.0/conv1/Conv")
#loc20 = loc("/layer2/layer2.0/relu/Relu")
#loc21 = loc("Initializer_onnx::Conv_215")
#loc22 = loc("/layer2/layer2.0/downsample/downsample.0/Conv")
#loc23 = loc("Initializer_onnx::Conv_212")
#loc24 = loc("/layer2/layer2.0/conv2/Conv")
#loc25 = loc("/layer2/layer2.0/Add")
#loc26 = loc("/layer2/layer2.0/relu_1/Relu")
#loc27 = loc("Initializer_onnx::Conv_218")
#loc28 = loc("Initializer_onnx::Conv_221")
#loc29 = loc("/layer2/layer2.1/conv1/Conv")
#loc30 = loc("/layer2/layer2.1/relu/Relu")
#loc31 = loc("/layer2/layer2.1/conv2/Conv")
#loc32 = loc("/layer2/layer2.1/Add")
#loc33 = loc("/layer2/layer2.1/relu_1/Relu")
#loc34 = loc("Initializer_onnx::Conv_224")
#loc35 = loc("/layer3/layer3.0/conv1/Conv")
#loc36 = loc("/layer3/layer3.0/relu/Relu")
#loc37 = loc("Initializer_onnx::Conv_230")
#loc38 = loc("/layer3/layer3.0/downsample/downsample.0/Conv")
#loc39 = loc("Initializer_onnx::Conv_227")
#loc40 = loc("/layer3/layer3.0/conv2/Conv")
#loc41 = loc("/layer3/layer3.0/Add")
#loc42 = loc("/layer3/layer3.0/relu_1/Relu")
#loc43 = loc("Initializer_onnx::Conv_233")
#loc44 = loc("Initializer_onnx::Conv_236")
#loc45 = loc("/layer3/layer3.1/conv1/Conv")
#loc46 = loc("/layer3/layer3.1/relu/Relu")
#loc47 = loc("/layer3/layer3.1/conv2/Conv")
#loc48 = loc("/layer3/layer3.1/Add")
#loc49 = loc("/layer3/layer3.1/relu_1/Relu")
#loc50 = loc("Initializer_onnx::Conv_239")
#loc51 = loc("/layer4/layer4.0/conv1/Conv")
#loc52 = loc("/layer4/layer4.0/relu/Relu")
#loc53 = loc("Initializer_onnx::Conv_245")
#loc54 = loc("/layer4/layer4.0/downsample/downsample.0/Conv")
#loc55 = loc("Initializer_onnx::Conv_242")
#loc56 = loc("/layer4/layer4.0/conv2/Conv")
#loc57 = loc("/layer4/layer4.0/Add")
#loc58 = loc("/layer4/layer4.0/relu_1/Relu")
#loc59 = loc("Initializer_onnx::Conv_248")
#loc60 = loc("Initializer_onnx::Conv_251")
#loc61 = loc("/layer4/layer4.1/conv1/Conv")
#loc62 = loc("/layer4/layer4.1/relu/Relu")
#loc63 = loc("/layer4/layer4.1/conv2/Conv")
#loc64 = loc("/layer4/layer4.1/Add")
#loc65 = loc("/layer4/layer4.1/relu_1/Relu")
#loc66 = loc("/avgpool/GlobalAveragePool")
#loc67 = loc("/Flatten")
#loc68 = loc("/fc/Gemm")
#loc69 = loc("Initializer_onnx::Conv_194")
#loc70 = loc(fused[#loc1, #loc2, #loc3, #loc4, #loc5, #loc6, #loc7, #loc8, #loc9, #loc10, #loc11, #loc12, #loc13, #loc14, #loc15, #loc16, #loc17, #loc18, #loc19, #loc20, #loc21, #loc22, #loc23, #loc24, #loc25, #loc26, #loc27, #loc28, #loc29, #loc30, #loc31, #loc32, #loc33, #loc34, #loc35, #loc36, #loc37, #loc38, #loc39, #loc40, #loc41, #loc42, #loc43, #loc44, #loc45, #loc46, #loc47, #loc48, #loc49, #loc50, #loc51, #loc52, #loc53, #loc54, #loc55, #loc56, #loc57, #loc58, #loc59, #loc60, #loc61, #loc62, #loc63, #loc64, #loc65, #loc66, #loc67, #loc68, #loc69])
#loc71 = loc(fused[#loc1, #loc2])
#loc72 = loc(fused[#loc5, #loc6])
#loc73 = loc(fused[#loc9, #loc10])
#loc74 = loc(fused[#loc13, #loc14])
#loc75 = loc(fused[#loc16, #loc17])
#loc76 = loc(fused[#loc19, #loc20])
#loc77 = loc(fused[#loc25, #loc26])
#loc78 = loc(fused[#loc29, #loc30])
#loc79 = loc(fused[#loc32, #loc33])
#loc80 = loc(fused[#loc35, #loc36])
#loc81 = loc(fused[#loc41, #loc42])
#loc82 = loc(fused[#loc45, #loc46])
#loc83 = loc(fused[#loc48, #loc49])
#loc84 = loc(fused[#loc51, #loc52])
#loc85 = loc(fused[#loc57, #loc58])
#loc86 = loc(fused[#loc61, #loc62])
#loc87 = loc(fused[#loc64, #loc65])
#loc88 = loc(fused[#loc64, #loc65, #loc66])
#loc89 = loc(fused[#loc66, #loc67, #loc68])
