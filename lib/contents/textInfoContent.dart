import 'package:lingkung_courier/models/infoModel.dart';
import 'package:uuid/uuid.dart';

var uuid = Uuid();
String textInfoId = uuid.v4();

final textInfoNews = [
  InfoModel(
    id: textInfoId,
    category: "Berita",
    name: "Tubuh Mengonsumsi Sekitar 2.000 Partikel Plastik yang Berasal dari Makanan Ini",
    imageUrl: "https://akcdn.detik.net.id/community/media/visual/2019/03/12/b9db17b1-7a53-4ae7-b127-637208219354_169.jpeg?w=700&q=90",
    linkUrl: "https://health.detik.com/berita-detikhealth/d-4584725/tubuh-mengonsumsi-sekitar-2000-partikel-plastik-yang-berasal-dari-makanan-ini",
    source: "detikHealth",
  ),
  
  InfoModel(
    id: textInfoId,
    category: "Berita",
    name: "Waspada Bahaya Sampah Plastik",
    imageUrl: "https://skata.info/MFfiles/artikel/skata-1546832795.jpg",
    linkUrl: "https://skata.info/article/detail/337/waspada-bahaya-sampah-plastik#:~:text=Sampah%20plastik%20yang%20dibakar%20akan%20mencemari%20lingkungan%20karena%20dalam%20asap,kanker%2C%20dan%20gangguan%20sistem%20syaraf.",
    source: "skata",
  ),
  
  InfoModel(
    id: textInfoId,
    category: "Berita",
    name: "Cerita Fahri, Penjaga Pulau Tulang dari Bahaya Sampah Plastik",
    imageUrl: "https://blue.kumparan.com/image/upload/fl_progressive,fl_lossy,c_fill,q_auto:best,w_640/v1597540147/jqknrqmelnu4nkny0vca.jpg",
    linkUrl: "https://kumparan.com/ceritamalukuutara/cerita-fahri-penjaga-pulau-tulang-dari-bahaya-sampah-plastik-1u0kCm8z7yK",
    source: "kumparan",
  ),
  
  InfoModel(
    id: textInfoId,
    category: "Berita",
    name: "Limbah plastik bisa dimanfaatkan menjadi bahan bangunan, bagaimana caranya?",
    imageUrl: "https://ichef.bbci.co.uk/news/800/cpsprodpb/EF91/production/_114192316_p08p27fm.jpg",
    linkUrl: "https://www.bbc.com/indonesia/vert-fut-53980201",
    source: "BBC News",
  ),
  
  InfoModel(
    id: textInfoId,
    category: "Berita",
    name: "Danger! Used face masks are toxic waste",
    imageUrl: "https://assets.nst.com.my/images/articles/PELITUP_MUKA_1598241731.jpg",
    linkUrl: "https://www.nst.com.my/news/nation/2020/08/618875/danger-used-face-masks-are-toxic-waste",
    source: "New Straits Time",
  ),
];

final textInfoTutorial = [
  InfoModel(
    id: textInfoId,
    category: "Tutorial",
    name: "30 Cara Mudah Membuat Kerajinan Tangan dari Barang Bekas",
    imageUrl: "https://www.duniaq.com/wp-content/uploads/2020/06/KERAJINAN-TANGAN-KALENG-BEKAS-UNTUK-TEMPAT-PERALATAN-DAPUR.jpg",
    linkUrl: "https://www.duniaq.com/30-cara-mudah-membuat-kerajinan-tangan-dari-barang-bekas/",
    source: "duniaq",
  ),
  
  InfoModel(
    id: textInfoId,
    category: "Tutorial",
    name: "Cara Membuat Pupuk Kompos Dari Sampah Rumah Tangga. Mudah Lho!",
    imageUrl: "https://blogpictures.99.co/cara-membuat-pupuk-kompos-header.jpg",
    linkUrl: "https://www.99.co/blog/indonesia/cara-membuat-pupuk-kompos/",
    source: "99",
  ),
  
  InfoModel(
    id: textInfoId,
    category: "Tutorial",
    name: "Cara Memilah Sampah – Jawaban dari pengganti Plastik sampah",
    imageUrl: "https://zerowaste.id/wp-content/uploads/2018/09/active-cleaning-daylight-1201588-scaled.jpg",
    linkUrl: "https://zerowaste.id/waste/cara-memilah-sampah-jawaban-dari-pengganti-plastik-sampah/",
    source: "Zero Waste",
  ),
  
  InfoModel(
    id: textInfoId,
    category: "Tutorial",
    name: "Langkah Mudah dan Sederhana Mengurangi Sampah Plastik di Rumah",
    imageUrl: "https://www.seva.id/wp-content/uploads/2019/10/shutterstock_1453632491.jpg",
    linkUrl: "https://www.seva.id/blog/langkah-mudah-mengurangi-sampah-plastik-di-rumah-102019/",
    source: "Seva",
  ),
  
  InfoModel(
    id: textInfoId,
    category: "Tutorial",
    name: "Ingin Mengurangi Polusi Udara di dalam Rumah? Lakukan Hal Berikut",
    imageUrl: "https://asset-a.grid.id/crop/0x0:0x0/700x465/photo/2019/08/19/1443268180.jpg",
    linkUrl: "https://nationalgeographic.grid.id/read/131900097/ingin-mengurangi-polusi-udara-di-dalam-rumah-lakukan-hal-berikut?page=all",
    source: "National Geographic",
  ),
  
];