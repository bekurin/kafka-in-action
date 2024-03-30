import org.apache.kafka.clients.producer.KafkaProducer
import org.apache.kafka.clients.producer.ProducerConfig
import org.apache.kafka.clients.producer.ProducerRecord
import org.apache.kafka.common.serialization.StringSerializer
import org.slf4j.Logger
import org.slf4j.LoggerFactory
import java.util.*

class SimpleProducer {
    private val logger: Logger = LoggerFactory.getLogger(SimpleProducer::class.java)

    companion object {
        const val TOPIC_NAME = "test"
        const val BOOTSTRAP_SERVER = "my-kafka:9092"
    }
}

fun main() {
    val config = Properties()
    config.put(ProducerConfig.BOOTSTRAP_SERVERS_CONFIG, SimpleProducer.BOOTSTRAP_SERVER)
    config.put(ProducerConfig.KEY_SERIALIZER_CLASS_CONFIG, StringSerializer::class.java)
    config.put(ProducerConfig.VALUE_SERIALIZER_CLASS_CONFIG, StringSerializer::class.java)

    val producer = KafkaProducer<String, String>(config)

    val messageValue = "testMessage"
    val record = ProducerRecord<String, String>(SimpleProducer.TOPIC_NAME, messageValue)
    producer.send(record)
    producer.flush()
    producer.close()
}
