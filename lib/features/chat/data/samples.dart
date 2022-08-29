import 'package:tranquil_life/features/chat/domain/entities/message.dart';
import 'package:tranquil_life/features/chat/domain/entities/reply.dart';

const _textMessage = Message(
  id: 0,
  data: 'Hi, I have been some issues for a while and I need help.',
  fromYou: false,
);
const _videoMessage = Message(
  id: 3,
  data: 'https://www.pexels.com/video/3195394/download/',
  type: MessageType.video,
);

const _audioMessage = Message(
  id: 5,
  data: 'https://sounds-mp3.com/mp3/0001961.mp3',
  type: MessageType.voiceNote,
  fromYou: false,
);

const _imageMessage = Message(
  id: 7,
  type: MessageType.image,
  data:
      'https://media-exp1.licdn.com/dms/image/C4D03AQG9RwdZxoR3LA/profile-displayphoto-shrink_800_800/0/1641042314872?e=1664409600&v=beta&t=3i2pGW6GJaM47SVvonYStK24fA_OJO3nMbHq8JcFfZk',
);

const messages = [
  ReplyMessage(
    id: 1,
    data: 'https://www.pexels.com/video/3195394/download/',
    repliedMessage: _imageMessage,
  ),
  ReplyMessage(
    id: 2,
    data: 'https://www.pexels.com/video/3195394/download/',
    repliedMessage: _textMessage,
    type: MessageType.video,
  ),
  _videoMessage,
  ReplyMessage(
    id: 4,
    data: 'https://sounds-mp3.com/mp3/0001961.mp3',
    repliedMessage: _videoMessage,
    type: MessageType.voiceNote,
  ),
  _textMessage,
  _audioMessage,
  ReplyMessage(
    id: 6,
    type: MessageType.image,
    repliedMessage: _audioMessage,
    data:
        'https://media-exp1.licdn.com/dms/image/C4D03AQG9RwdZxoR3LA/profile-displayphoto-shrink_800_800/0/1641042314872?e=1664409600&v=beta&t=3i2pGW6GJaM47SVvonYStK24fA_OJO3nMbHq8JcFfZk',
    fromYou: false,
  ),
  _imageMessage,
  Message(
    id: 8,
    data: 'Hi, I have been some issues.',
  ),
];
