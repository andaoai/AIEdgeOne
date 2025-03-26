from abc import ABC, abstractmethod

class EdgeInferenceBase(ABC):
    @abstractmethod
    def load_model(self, model_path: str, config: dict):
        """加载设备专用模型"""
    
    @abstractmethod
    def infer(self, input_data):
        """执行推理并返回结果"""
    
    @classmethod
    def create(cls, device_type: str):
        # 动态加载设备实现（如nvidia.Inference）
        module = __import__(f"edge_devices.{device_type}", fromlist=["Inference"])
        return module.Inference()
