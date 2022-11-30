<?php

declare(strict_types=1);

namespace App\Repository;

use App\Exception\PeriodByApiKeyNotFoundException;
use App\Model\Period;
use DateTimeImmutable;

class SpecificationPeriodRepository extends AbstractNonEntityRepository
{
    public function findPeriodByApiKey(string $apiKey): Period
    {
        $sql = <<<EOF
SELECT vz.von, vz.bis
FROM api_apikey aa
    INNER JOIN vorgaben_zeitraum vz ON (vz.zeitraum_id = aa.zeitraum_id)
WHERE aa.apikey = :apiKey
EOF;
        $stmt = $this->getConnection()->prepare($sql);
        $resultSet = $stmt->executeQuery(['apiKey' => $apiKey]);

        $result = $resultSet->fetchAssociative();

        if (!$result) {
            throw new PeriodByApiKeyNotFoundException();
        }

        return new Period(
            new DateTimeImmutable($result['von']),
            new DateTimeImmutable($result['bis']),
        );
    }
}
