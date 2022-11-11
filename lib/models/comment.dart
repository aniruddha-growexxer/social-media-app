class Comment {
  String authorName;
  String authorImageUrl;
  String text;

  Comment({
    required this.authorName,
    required this.authorImageUrl,
    required this.text,
  });
}

final List<Comment> comments = [
  Comment(
    authorName: 'Tim Cook',
    authorImageUrl: 'assets/images/user4.jpeg',
    text: 'Cool!',
  ),
  Comment(
    authorName: 'Miranda',
    authorImageUrl: 'assets/images/user1.jpeg',
    text: 'Cool!',
  ),
  Comment(
    authorName: 'Ingrid Broun',
    authorImageUrl: 'assets/images/user2.jpeg',
    text: 'Cool!',
  ),
  Comment(
    authorName: 'Addy Rock',
    authorImageUrl: 'assets/images/user3.jpeg',
    text: 'Cool!',
  ),
  Comment(
    authorName: 'Fill G',
    authorImageUrl: 'assets/images/user0.jpeg',
    text: 'Cool!',
  ),
];
