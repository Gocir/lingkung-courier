import 'package:lingkung_courier/models/infoModel.dart';
import 'package:uuid/uuid.dart';

var uuid = Uuid();
String videoInfoId = uuid.v4();

final videoInfoNews = [
  InfoModel(
    id: videoInfoId,
    category: "Berita",
    name: 'Bekasi "Tempat Sampah" Dunia',
    imageUrl: "https://i.ytimg.com/vi/DgXcGL0eXv0/hqdefault.jpg?sqp=-oaymwEYCKgBEF5IVfKriqkDCwgBFQAAiEIYAXAB&rs=AOn4CLBIW6TNmy40E0RsXvEFtlX3QIJL6A",
    linkUrl: "https://youtu.be/DgXcGL0eXv0",
    source: "CNN Indonesia",
  ),
  
  InfoModel(
    id: videoInfoId,
    category: "Berita",
    name: "Kisah Tragis Hewan Laut yang Terdampak Sampah Plastik Manusia..",
    imageUrl: "https://i.ytimg.com/vi/ytVjFSy8pWg/hqdefault.jpg?sqp=-oaymwEYCKgBEF5IVfKriqkDCwgBFQAAiEIYAXAB&rs=AOn4CLAbpC85j6Pvtt2TcOo-7dfRAfDb1Q",
    linkUrl: "https://youtu.be/ytVjFSy8pWg",
    source: "Daftar Populer",
  ),
  
  InfoModel(
    id: videoInfoId,
    category: "Berita",
    name: "6 Roof and Pavement Tiles from Plastic Waste",
    imageUrl: "https://i.ytimg.com/vi/ckWqR1JD158/hqdefault.jpg?sqp=-oaymwEYCKgBEF5IVfKriqkDCwgBFQAAiEIYAXAB&rs=AOn4CLCUxGdbfFbU6hUAlNphsKaL4JXhuQ",
    linkUrl: "https://youtu.be/ckWqR1JD158",
    source: "Earth Titan",
  ),
  
  InfoModel(
    id: videoInfoId,
    category: "Berita",
    name: "Kurangi Pencemaran Lingkungan, Mahasiswa Ubah Limbah Jadi Pupuk Organik",
    imageUrl: "https://i.ytimg.com/vi/lrfYbQCVNCM/hqdefault.jpg?sqp=-oaymwEYCKgBEF5IVfKriqkDCwgBFQAAiEIYAXAB&rs=AOn4CLA1q7CmlEchIdZVIylwpSn2RAKmug",
    linkUrl: "https://youtu.be/lrfYbQCVNCM",
    source: "KOMPASTV",
  ),
  
  InfoModel(
    id: videoInfoId,
    category: "Berita",
    name: "Inilah Akar Permasalahan Lingkungan Hidup",
    imageUrl: "https://i.ytimg.com/vi/ruH03WooR_8/hqdefault.jpg?sqp=-oaymwEYCKgBEF5IVfKriqkDCwgBFQAAiEIYAXAB&rs=AOn4CLAHAq9kN_rJSffvA8FT8rIgm4rTeg",
    linkUrl: "https://youtu.be/ruH03WooR_8",
    source: "Indonesia Morning Show NET",
  ),
];

final videoInfoTutorial = [
  InfoModel(
    id: videoInfoId,
    category: "Tutorial",
    name: "10 Ways to Reduce Waste | Zero Waste for Beginners",
    imageUrl: "https://i.ytimg.com/vi/OagTXWfaXEo/hqdefault.jpg?sqp=-oaymwEYCKgBEF5IVfKriqkDCwgBFQAAiEIYAXAB&rs=AOn4CLBhj7ANpmrvq7rIpTXPDEikKB5obQ",
    linkUrl: "https://youtu.be/OagTXWfaXEo?list=TLPQMDgwOTIwMjBZPlhbbmEEKA",
    source: "Lavendaire",
  ),
  
  InfoModel(
    id: videoInfoId,
    category: "Tutorial",
    name: "Tutorial Hidroponik untuk Pemula",
    imageUrl: "https://i.ytimg.com/vi/9l-ti-tT9xw/hqdefault.jpg?sqp=-oaymwEYCKgBEF5IVfKriqkDCwgBFQAAiEIYAXAB&rs=AOn4CLAKkqi7bC98Bd_sfE_bqAoplGj3Pw",
    linkUrl: "https://youtu.be/9l-ti-tT9xw?list=TLPQMDgwOTIwMjDfTekVUB8uzA",
    source: "HIDROPONIKPEDIA",  
  ),
  
  InfoModel(
    id: videoInfoId,
    category: "Tutorial",
    name: "RECYCLING LUX SOAP PACKET REUSE IDEA | BEST OUT OF WASTE | WASTE MATERIALS CRAFTING",
    imageUrl: "https://i.ytimg.com/vi/KKK-35UZB5U/hqdefault.jpg?sqp=-oaymwEYCKgBEF5IVfKriqkDCwgBFQAAiEIYAXAB&rs=AOn4CLAN2JNEUmAyDBForZb3kvhcIRkByg",
    linkUrl: "https://youtu.be/KKK-35UZB5U?list=TLPQMDgwOTIwMjAccyMLODtcew",
    source: "S R Hacks",
  ),
  
  InfoModel(
    id: videoInfoId,
    category: "Tutorial",
    name: "How to Use BSF Biowaste Treatment - Step by Step",
    imageUrl: "https://i.ytimg.com/vi/5M6u9ZX5ecE/hqdefault.jpg?sqp=-oaymwEYCKgBEF5IVfKriqkDCwgBFQAAiEIYAXAB&rs=AOn4CLAbo52kJVTJbwg3sOieclAMp5umyw",
    linkUrl: "https://youtu.be/5M6u9ZX5ecE?list=TLPQMDgwOTIwMjBZPlhbbmEEKA",
    source: "Sandec Eawag",
  ),
  
  InfoModel(
    id: videoInfoId,
    category: "Tutorial",
    name: "CARA MEMBUAT NUTRISI HIDROPONIK YANG ORGANIK | MOL untuk Hidroponik",
    imageUrl: "https://i.ytimg.com/vi/v2tiLMuyPWI/hqdefault.jpg?sqp=-oaymwEYCKgBEF5IVfKriqkDCwgBFQAAiEIYAXAB&rs=AOn4CLDWAGljYoUeUBZAp3eXiSKi_vZLhg",
    linkUrl: "https://youtu.be/v2tiLMuyPWI?list=TLPQMDgwOTIwMjDfTekVUB8uzA",
    source: "Urban Farming Indonesia",
  ),
  
];