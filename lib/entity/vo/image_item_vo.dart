class ImageItemVO {

  const ImageItemVO(this.id, this.name, this.avatarUrl, this.imageUrl);

  const ImageItemVO.empty() : this(0, "", "", "");

  final int id;
  final String name;
  final String avatarUrl;
  final String imageUrl;
}
